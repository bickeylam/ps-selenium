namespace MyTester.Test.Tests
{
    using System;
    using System.Diagnostics;
    using System.IO;
    using System.Reflection;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using OpenQA.Selenium;
    using OpenQA.Selenium.Chrome;

    [TestClass]
    public class NonBrowserBasedTest
    {
        public TestContext TestContext { get; set; }

        [TestInitialize]
        public void BeforeTest()
        {
        }

        [TestCleanup]
        public void AfterTest()
        {
        }

        [DataTestMethod]
        [DataRow(1, 2, 3)]
        [TestCategory("smoke")]
        public void GivenTwoNumbersWhenAddThenResultCalculated(int a, int b, int expected)
        {
            int actual = a + b;

            Assert.AreEqual<int>(expected, actual);
            TestContext.WriteLine($@"Result: {actual}");
            Debug.WriteLine($@"Debug: {actual}");
            Trace.WriteLine($@"Trace: {actual}");
        }
    }
}
