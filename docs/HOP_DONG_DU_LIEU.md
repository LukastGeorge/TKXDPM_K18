# Hợp đồng dữ liệu và trách nhiệm thiết kế

Thiết kế dự kiến, chưa phải chữ ký Java đã triển khai. DTO/value object bất biến về hợp đồng; không đưa HTTP/JPA/framework vào core. [0..1] là tùy chọn; Decimal là số thập phân chính xác, dự kiến BigDecimal; không dùng double cho tiền.

## Luồng Input/Output Boundary

Controller kiểm định dạng, lấy Subject từ server → Request Model → Input Boundary → Interactor kiểm quyền/nghiệp vụ → domain/ports → Response Model → Output Boundary → Presenter → ViewModel → controller trả HTTP. Boundary do application sở hữu. Presenter có trạng thái phải riêng theo request.

execute(request):void không trả Response trực tiếp; interactor gọi output.present(response). Lỗi nghiệp vụ cũng đi qua port này. Lỗi payload không giải mã được có thể dừng tại adapter. PricingService.quote là lời gọi nội bộ trả QuoteResult, không phải delivery boundary. Use case không import concrete presenter.

## Request, response và dữ liệu

| Use case / UML | Input, nguồn | Nơi kiểm tra | Output, người nhận | Ghi/lỗi |
|---|---|---|---|---|
| Catalog / SQ01, CL02 | criteria keyword/category/min/max/page; SKU; subject nếu admin | adapter format; application quyền/public scope | CatalogResponse items/paging/detail/errors → presenter | Chỉ đọc, lỗi không sửa danh mục |
| ChangeCart / CL01, SQ02 | Subject server; cartId; LineSelection; qty; expectedVersion | usecase owner; Cart qty; pricing quan hệ/giá | ChangeCartResponse status, snapshot?,errors → presenter | CAS version; lỗi giữ giỏ cũ; không giữ kho |
| MergeCart / SQ02B | guestCartRef gắn phiên, account từ đăng nhập | nguồn/đích/transfer, qty/giá | giỏ hoặc cần điều chỉnh → presenter | P-MERGE chưa duyệt; giỏ+transfer cùng commit; retry không cộng |
| Pricing / CL03, SQ03 | PricingContext backendLines, subject, code?,serverNow; offers hiện hành | PricePolicy/PromotionCode | QuoteResult quote/errors → Cart/Checkout interactor | Không giữ kho/quota; QD-02, chi tiết giá còn mở |
| PlaceOrder / CL04, SQ04 | subject, cartId, cartVersion, acceptedQuote, delivery, key | email verified, owner, key; backend giá; tổng SKU/quota dưới khóa | PlaceOrderResponse status, order?,newQuote?,errors → presenter | D01 order+stock+quota+cart+key cùng commit; rollback hoặc tra key nếu outcome unknown |
| QueryOrder / SQ06B | orderId?,page; Subject server | owner AND id; admin qua quyền riêng | OrderResponse snapshots/trạng thái → presenter | Chỉ đọc, không lộ đơn khác |
| Cancel / SQ06/06C | orderId, cancelKey, reason, Subject | quyền/trạng thái dưới khóa | CancelResponse status, releasedAmounts, error | Giải phóng reservation một lần, H không đổi; quota timing còn đề xuất |
| Warehouse / SQ07 | type, documentKey, SKU/orderId, qty, reason, Subject | quyền; SKU tồn tại; qty/actual>=R | WarehouseResponse H, R, A, documentId/errors | Phiếu+tồn+đơn nếu bàn giao cùng commit; n xuất từ reservation |
| COD / SQ05 | orderId, receiptKey, deliveryResult, amount, Subject | admin/trạng thái theo P-STATE; số tiền khớp | CODResponse trạng thái, amountRecorded, error | Không xuất lại; lưu key độc lập cash receipt, cả total0/thất bại |
| Register / SQ08, CL06–07 | name, email, password, confirmation | format/unique email; hashing; customer role server | IdentityResponse accountId, needsVerification, sendStatus/errors | Account+token+job nguyên tử D02; provider mail thật sau commit |
| VerifyEmail / SQ08 | token liên kết; now từ clock server | hash/account/hạn/chưa dùng | verified/invalid/expired/alreadyUsed → presenter | Tiêu token+verify cùng commit; không tự đăng nhập |
| Login/Logout / AD08, CL06 | credentials/sessionRef | account active/password verifier/revoke | IdentityResponse phiên/quyền từ server | Không lộ password/hash; TTL còn mở |
| Facebook / SQ08B | code, state, sessionRef từ callback | state một lần; server kiểm provider subject; linking | IdentityResponse hoặc redirect/error → presenter | Provider ngoài transaction; lỗi không cấp phiên; email chưa verify không đặt |
| Admin / SQ09 | resource/action/id/version/fields; Subject | allowlist; quyền kiểm lại trong usecase; tham chiếu/lịch sử | response đúng nghiệp vụ → presenter | Không CRUD trực tiếp trạng thái kho/đơn/tiền |

## Hợp đồng phương thức chính

| Phương thức | Tiền điều kiện và đơn vị | Kết quả / ví dụ | Lỗi và tác động phụ |
|---|---|---|---|
| ChangeCartInputBoundary.execute | Subject từ server; qty nguyên >= 0; selection/id/version | present đúng một lần; qty0 bỏ dòng theo chính sách | Sai owner/qty/version: lỗi, giỏ đã lưu giữ nguyên |
| Cart.changeLine / removeLine | Cart hợp lệ, qty>=0; liên kết kèm theo BR | Đổi dự kiến trong aggregate; không gọiDB | Invariant sai không sửa một phần |
| CartPort.loadOwned / save | owner từ server; version đã đọc | Aggregate đúng chủ; save tăng version | NotFound/Forbidden không lộ chủ; conflict không ghi đè |
| PricingService.quote / PricePolicy.calculate | lines backend, offers hiện hành, serverNow, tiền cùng currency | Coupon 20%/240000→192000 trong fixture; quote cóversion | Mã/recipe sai trả lý do, không giữ quota/kho |
| PromotionCode.check | chủ/điều kiện/time/quota server | EligibilityResult, chưa dùng mã | Không đủ điều kiện không sửa giá đã lưu |
| Money.add / multiply | Cùngcurrency; qty nguyên >= 0 | Giá trị mới, không sửa bản cũ | Sai tiền tệ/qty trả lỗi; rounding theo BR chưa chốt |
| PlaceOrderInputBoundary.execute | verifiedEmail; giỏ/quote/delivery/key hợp lệ | Saucommit present order; COD chưa thu, giữ1 lần | Requote/conflict/thiếu/lỗi: không ghi dở |
| CheckoutUnitOfWork.run | CheckoutWork dùng context trong transaction | Mộtcommit cho toàn bộ staged changes | Lỗi trước commit rollback; không rõcommit phải tra key, không coi là thất bại chắc chắn |
| CheckoutContext.claim | owner+action+key; digest tính phía server | New/Replay/Conflict trước khi đọc giỏ | Unique/lock thật phải kiểm G4; retention còn mở |
| CheckoutContext.loadCart / lockStock / stage | owner, SKUđã gộp, thứ tự khóa, snapshot xác nhận | Dữ liệu nhất quán, stage order/reserve/quota/cart/key | stage không tựcommit; không expose SQL/JPA |
| StockBalance.reserve(qty) | qty>0, qty<=H−R | H10/R0 reserve2→H10/R2 | Thiếu giữ nguyên; atomic nhiềuSKU thuộcUoW |
| StockBalance.release(qty) | qty thuộc reservation Held của đúng đơn | R-=qty, H không đổi | UoW/Reservation chặn Released/Issued gọi lại |
| StockBalance.issueReserved(qty) | reservation Held, bàn giao hợp lệ | H-=qty, R-=qty, A không đổi | Đồng bộ trạng thái/phiếu/tồn hoặcrollback |
| StockBalance.adjust(actual, reason) | actual>=R, lý do có nội dung; quyền ởusecase | H=actual, R giữ nguyên; phiếu ghi chênh lệch | Không làm mất lượng giữ |
| Reservation.markReleased / markIssued | Chỉ từ Held | Released/Issued; retry do use case trả kết quả cũ | Không Released→Issued hoặc ngược |
| Order.confirm/cancelBeforeHandover/handover/complete | P-STATE/quyền; complete đòi settlement phù hợp | ĐúngST01, snapshot không đổi | Không cạnh tắt; Order không tự chạm repository kho |
| CodSettlement.record | Đúng đơn, số tiền=amountDue>0, key; P-STATE | Thu 1 lần; total0 dùng NoCollection, không có receipt bằng 0 | Sai giữ tiền; không tự giảmstock |
| RequestRecord.replayIfSame | Đúngowner/action/key | Cùngdigest trảStoredResult | Khácdigest conflict, không sửađơn |
| VerificationToken.consume / Account.verifyEmail | Token đúng account/chưa dùng/còn hạn; proofcore tạo | Consume+verify cùng commit | Không nhận proof tự gửi từ JSON; sai/hết hạn không verify |
| AccountPort.createPending / saveVerified | Account/token/jobhợp lệ; email unique | Cùngcommit dữ liệu theo hợp đồng | Lỗi không ghi dở, password hash trước lưu |
| MailDeliveryPort.send / MailJobWorker.processPending | Job đã commit, link/email hợp lệ, provider thật | Accepted/Retryable/PermanentFailure; ghi attempt | Khôngverify account; có thể gửi thư trùng nếu providerđã nhận mấtresponse |
| FacebookIdentityPort.exchange | Code thuộc luồng state đã kiểm, credential ngoài core | Provider subject đãxácminh hoặcerror | Timeout/state/code sai không cấp phiên giả |
| OutputBoundary.present / Presenter.viewModel | Response phù hợpstatus; instance theo request | Định dạng an toàn; đọcViewModel sauexecute | Không lộ hash/token, không giữ model chunggiữa khách |

## Kiểu phụ trên Class UML

Đây là từ điển kiểu thiết kế, không yêu cầu tạo class trống hàng loạt.

- Sku, CartId, LineId, OfferId, AccountId, OrderId, CategoryId, MailJobId là ID không rỗng theo giá trị. RequestKey định danh hành động của chủ.
- Subject gồm accountId? hoặc guestSessionId? và quyền/trạng thái server. CartOwner là chủ guest/account. RoleSet là quyền lấy từ nguồn tin cậy.
- LineSelection chứa offerId, SaleMode, sku? và liên kết dòng chính trong CartLine. SaleMode: REGULAR/PRODUCT_DISCOUNT/WHOLESALE/COMBO/ADD_ON. SkuQuantity=(sku, qty>0); hậu tố List là danh sách kiểu tương ứng.
- CartSnapshot, OrderSnapshot, PriceQuoteData là bản sao DTO được phép hiển thị, không phải aggregate/JPA entity. OrderSnapshot gồm owner, lines, recipe, giá/giảm/phí/tổng, delivery, trạng thái đơn/tiền.
- OfferSnapshot gồm offerId, mode, SKU/recipe, giá, version, conditions. QuoteVersion/QuoteReference chỉ phiên bản/nội dung người mua đã chấp nhận; backend vẫn kiểm lại.
- PricingContext gồm backendLines, Subject, code?,serverNow, feesPolicy. CodeConditions gồm hạn/ngưỡng/quota/khách/phạm vi. CodeKind=COUPON_PERCENT/VOUCHER_FIXED. Currency là đơn vị tiền, fixture VND.
- DeliveryData gồm tên, điện thoại, địa chỉ. BookDetails/SearchCriteria/BookPage/BookDetailsResult chỉ dữ liệu public/phân trang BR-002/031.
- ChangeCartRequest/Response và PlaceOrderRequest/Response đúng CL01/04. RegisterRequest gồm name/email/password/confirmation; VerifyEmailRequest gồm token; LoginRequest gồm email/password; LogoutRequest gồm sessionRef server; FacebookCallbackRequest gồm code/state/sessionRef.
- IdentityResponse gồm status, accountId?, role?,emailVerified?,sendStatus?,redirect?,errors. Cookie/session delivery tạo theo kết quả hợp lệ, không nhận role do clienttự gửi.
- CartViewModel/OrderViewModel/IdentityViewModel thuộc adapter. HttpPayload/HttpResponse chỉ xuất hiện ở delivery.
- ValidationError=(code, field?,safeMessage). CartResultStatus/CheckoutStatus/AccountStatus/TransferStatus/SendState là enum dự kiến, cần chốt chi tiết.
- OrderStatus/PaymentStatus/ReservationStatus theo ST01/02/03, các chính sách chưa chốt vẫn ghi rõ.
- QuoteResult/EligibilityResult/SaveResult/ClaimResult/CheckoutResult/ReplayResult/AccountResult/MailJobResult/ExternalIdentityResult/MailSendResult phân biệt success/error, không đồng thời cả hai.
- CheckoutWork là thao tác nhận CheckoutContext trả kết quả trong run. CheckoutChanges gồm ghi order/stock/reservation/quota/cart/key. StockSnapshot chứa H/R/version theo SKU, không expose Connection.
- StoredResult là dữ liệu trả lại sau commit. Digest là fingerprintserver. SecretHash không xuất trong publicDTO/log.
- EmailAddress đã kiểmformat. Instant thời điểmserver. VerifiedEmailProof gắn account/token do core tạo. Provider trongphạm vi là FACEBOOK. VerificationMessage gồm recipient và linkhợp lệ.

Class UML chỉ thành phần chính, chưa là mọi lớp hoặc bảng. Hashing/session/clock cần port/adapter phù hợp ở G3. Nhóm IdentityInputBoundary có thể tách theo client khi code để giữ ISP. Không coi constructor injection là bằng chứng đầy đủ của DIP; composition root nối implementation, core phụ thuộc hợp đồng sở hữu ở application.
