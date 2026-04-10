package com.pgfinder;

import org.junit.platform.suite.api.SelectPackages;
import org.junit.platform.suite.api.Suite;
import org.junit.platform.suite.api.SuiteDisplayName;

@Suite
@SuiteDisplayName("PG Finder Complete Test Suite")
@SelectPackages({
    "com.pgfinder.dao",
    "com.pgfinder.model",
    "com.pgfinder.service",
    "com.pgfinder.filter",
    "com.pgfinder.util",
    "com.pgfinder.integration"
})
public class AllTests {
    // This class remains empty, it is used only as a holder for the above annotations
}
