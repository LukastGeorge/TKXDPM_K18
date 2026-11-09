package vn.bookshop.acceptance;
import org.junit.platform.suite.api.*;
/** Selects only the approved slice from the single canonical feature; other cases are NOT claimed passed. */
@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features/web_ban_sach_tinh_nang.feature")
@ConfigurationParameter(key="cucumber.glue",value="vn.bookshop.acceptance")
@ConfigurationParameter(key="cucumber.filter.tags",value="@s1")
@ConfigurationParameter(key="cucumber.plugin",value="pretty,json:target/cucumber-s1.json,html:target/cucumber-s1.html")
public class S1AcceptanceTest {}
