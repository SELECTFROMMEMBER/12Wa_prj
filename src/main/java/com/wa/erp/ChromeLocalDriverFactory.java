package com.wa.erp;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import io.github.bonigarcia.wdm.WebDriverManager;
import lombok.extern.slf4j.Slf4j;

@Slf4j

class ChromeLocalDriverFactory{

	//chrome.driver 버전 확인 필수
    private final static String WEB_DRIVER_ID = "webdriver.chrome.driver";
    //경로
    private final static String WEB_DRIVER_PATH = "C:\\zzz\\chromedriver-win64\\chromedriver.exe";


    private final ChromeOptions chromeOptions;

    ChromeLocalDriverFactory(ChromeOptions chromeOptions) {
        this.chromeOptions = chromeOptions;
    }
    
    WebDriver driver() {

        //드라이버 설정
        try {
        	System.setProperty("webdriver.http.factory", "jdk-http-client");
            System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
        } catch (Exception e) {
            e.printStackTrace();
            //log.error("WebDriver 설정 중 오류 발생: ", e);
        }
        
//        log.info("WebDriver ID: {}", WEB_DRIVER_ID);
//        log.info("WebDriver 경로: {}", WEB_DRIVER_PATH);

//        WebDriverManager.chromedriver().setup();
        return new ChromeDriver(chromeOptions);
    }


}