namespace MyTester.Test.Tests
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;
    using System.Reflection;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using OpenQA.Selenium;
    using OpenQA.Selenium.Chrome;

    [TestClass]
    public class BrowserBasedTest
    {
        private readonly string DriverPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
        private readonly string BaseUrl = @"http://www.google.com";
        private readonly TimeSpan DefaultWait = TimeSpan.FromSeconds(10);
        private IWebDriver driver;
        public TestContext TestContext { get; set; }

        [TestInitialize]
        public void BeforeTest()
        {
            driver = LoadDriver();
            driver.Navigate().GoToUrl(BaseUrl);
        }

        [TestCleanup]
        public void AfterTest()
        {
            driver?.Manage().Cookies.DeleteAllCookies();
            driver?.Close();
            driver?.Quit();
        }

        [TestMethod]
        [TestCategory("smoke")]
        public void GivenSeleniumWhenSearchThenPageTitleVerified()
        {
            string term = "Selenium";
            string expected = "Selenium - Google Search";

            IWebElement searchText = driver.FindElement(By.Name("q"));
            searchText.SendKeys(term);
            searchText.Submit();

            string actual = driver.Title;
            Assert.AreEqual<string>(expected, actual);
            TestContext.WriteLine($@"PageTitle: {actual}");
            Debug.WriteLine($@"Debug: {actual}");
            Trace.WriteLine($@"Trace: {actual}");
        }

        private IWebDriver LoadDriver()
        {
            ChromeOptions options = new ChromeOptions
            {
                AcceptInsecureCertificates = true
            };
            // options.AddArgument("--headless");
            options.AddArguments(new List<string> {
                "--headless",
                "--silent-launch",
                "--no-startu-window",
                "--no-sandbox"
            });
            IWebDriver driver = new ChromeDriver(DriverPath, options);
            driver.Manage().Timeouts().AsynchronousJavaScript = DefaultWait;
            driver.Manage().Timeouts().PageLoad = DefaultWait;
            driver.Manage().Timeouts().ImplicitWait = DefaultWait;
            driver.Manage().Cookies.DeleteAllCookies();
            driver.Manage().Window.Maximize();
            return driver;
        }
    }
}
