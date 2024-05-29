package com.wa.erp;

import lombok.extern.slf4j.Slf4j;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
public class NaverCrawling extends BaseCrawling {
  private final static String NAVER_URL = "https://news.naver.com/";

  @Override
  public void preCondition() {
	  driver = new DriverFactory().createInstance();
	  driver.manage().window().maximize();
	  wait = new WebDriverWait(driver, Duration.ofSeconds(5));
	  driver.get(NAVER_URL);
  }
  
  public void clickTab() {
	  wait.until(ExpectedConditions.presenceOfElementLocated(By.xpath("/html/body/section/header/div[2]/div/div/div/div/div/ul/li")));
	  NaverPage page = new NaverPage(driver);

	  List<WebElement> naverTabs = page.getTabs();

	  for(WebElement el : naverTabs) {
		  if(el.getText().equals("IT/과학")){
			  el.click();
			  break;
		  }
	  }
  }
  
  //class 가 sa_list 인 css를 찾아서 ui 태그를 바로 찾은 링크
  public HashMap getHeadLineInfo() {//*[@id="newsct"]
	  wait.until(ExpectedConditions.presenceOfElementLocated(By.xpath("//ul[@class=\"sa_list\"]/li")));


	  // return value
	  HashMap res = new HashMap();
	  
	  NaverPage page = new NaverPage(driver);

	  List<WebElement> headLineList = page.getHeadLineList();
	  WebElement moreHeadlinesButton = page.getMoreHeadlinesButton();
	  
	  moreHeadlinesButton.click();
	  
	  List<String> imgList = new ArrayList<String>();
	  List<String> hrefList = new ArrayList<String>();
	  List<String> textList = new ArrayList<String>();
	  
	  // li 태그들
	  for(WebElement el : headLineList) {
		  
		  // img 태그들
		  List<WebElement> images = el.findElements(By.cssSelector("div > div > div.sa_thumb._LAZY_LOADING_ERROR_HIDE > div > a > img"));
		  List<WebElement> aLinks = el.findElements(By.cssSelector("div > div > div.sa_thumb._LAZY_LOADING_ERROR_HIDE > div > a"));
		  List<WebElement> strongs = el.findElements(By.cssSelector("div > div > div.sa_text > a > strong"));
		  
		  for(WebElement img : images) {
			  scrollToElement(img);	
			  imgList.add(img.getAttribute("src"));
		  }
		  
		  for(WebElement aLink : aLinks) {
			  scrollToElement(aLink);
			  hrefList.add(aLink.getAttribute("href"));
		  }
		  
		  for(WebElement strong : strongs) {
			  scrollToElement(strong);
			  textList.add(strong.getText());
		  }
		  
	  }
//	  
//	  log.info("-----------------------------------------");
//	  log.info("imgList {}",imgList.toString());
//	  log.info("-----------------------------------------");
//	  log.info("hrefList {}",hrefList.toString());
//	  log.info("-----------------------------------------");
//	  log.info("textList {}",textList.toString());
//	  log.info("-----------------------------------------");

	  res.put("imgList",imgList);
	  res.put("hrefList",hrefList);
	  res.put("textList",textList);
	  
	  return res;
	  
  }
}
