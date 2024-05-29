package com.wa.erp;

import org.openqa.selenium.chrome.ChromeOptions;

class ChromeOptionsFactory {

    ChromeOptions build(){

        ChromeOptions optionsChrome = new ChromeOptions();
//        optionsChrome.addArguments("headless");
        optionsChrome.addArguments("--remote-allow-origins=*");
        optionsChrome.addArguments("start-maximized");
        optionsChrome.addArguments("lang=pt-BR");
//        optionsChrome.setCapability("chrome.switches", Arrays.asList("--ignore-certificate-errors,--web-security=false,--ssl-protocol=any,--ignore-ssl-errors=true"));
//        optionsChrome.setCapability("chrome.switches", "--disable-extensions");
        optionsChrome.setAcceptInsecureCerts(true);
        return optionsChrome;
    }
}
