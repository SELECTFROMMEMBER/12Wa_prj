package com.wa.erp;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.wa.erp.DriverFactory;

import java.time.Duration;

public abstract class BaseCrawling {

    protected static WebDriver driver;
    protected static WebDriverWait wait;

    public WebDriver getDriver() {
        return driver;
    }

    public void preCondition() {
        driver = new DriverFactory().createInstance();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(5));
    }

    public void postCondition(){
        driver.close();
        driver.quit();
    }

    public static void scrollToElement(WebElement element) {
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", element);
       
     }
}
