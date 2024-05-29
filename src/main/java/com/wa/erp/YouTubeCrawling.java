package com.wa.erp;

import lombok.extern.slf4j.Slf4j;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.wa.erp.DriverFactory;
import com.wa.erp.NaverPage;
import com.wa.erp.YouTubePage;

import org.openqa.selenium.support.ui.ExpectedConditions;

import java.lang.Character.Subset;
import java.time.Duration;
import java.util.*;

@Slf4j
public class YouTubeCrawling extends BaseCrawling {
  private final static String YouTube_URL = "https://www.youtube.com/results?search_query=%EC%B1%84%EC%9A%A9&sp=EgIIAw%253D%253D";

//  public void preCondition(String searchWord) {
  public void preCondition() {
	  driver = new DriverFactory().createInstance();
	  driver.manage().window().maximize();
	  wait = new WebDriverWait(driver, Duration.ofSeconds(5));
	  driver.get(YouTube_URL);  
  }
  
  public void clickTab() {//*[@id="contents"]
	  wait.until(ExpectedConditions.presenceOfElementLocated(By.xpath("/html/body/ytd-app/div[1]/div/ytd-masthead/div[4]/div[2]/ytd-searchbox/button")));
	  YouTubePage page = new YouTubePage(driver);
	  
	  //원하는 탭을 클릭
	  List<WebElement> YouTubeTabs = page.getTabs();
	  for(WebElement e2 : YouTubeTabs) {
		  
		  // youtube의 검색 돋보기 버튼 클릭
		  if(e2.getText().equals("#search-icon-legacy")){
			  e2.click();
			  break;
			  
		  }
	  }
  }
  
  public HashMap getHeadLineInfo() {//*[@id=\"contents\"]
	  wait.until(ExpectedConditions.presenceOfElementLocated(By.xpath("//*[@id=\"contents\"]/ytd-item-section-renderer")));
	  
	  // return value
	  HashMap res = new HashMap();
	  
	  YouTubePage page = new YouTubePage(driver);

	  List<WebElement> headLineList = page.getHeadLineList();
	  
	  List<Map<String,Object>> videoList = new ArrayList<Map<String,Object>>();
	  Map<String, Object> tempObj;
	  
	  // li 태그들
//	  for(WebElement e2 : headLineList) {
	  for(int i=0;i<headLineList.size();i++) {
	  
		  tempObj = new HashMap();
		  
		  // img 태그들
		  List<WebElement> images = headLineList.get(i).findElements(By.cssSelector("#thumbnail > yt-image > img"));
		  List<WebElement> aLinks = headLineList.get(i).findElements(By.cssSelector("#thumbnail"));
		  List<WebElement> strongs = headLineList.get(i).findElements(By.cssSelector("#video-title"));
	
		  for(WebElement img : images) {
			  scrollToElement(img);
			  tempObj.put("thumbnail", img.getAttribute("src"));
		  }
		  
		  for(WebElement aLink : aLinks) {
			  scrollToElement(aLink);
			  tempObj.put("url", aLink.getAttribute("href"));
		  }
		  
		  for(WebElement strong : strongs) {
			  scrollToElement(strong);
			  tempObj.put("title", strong.getText());
		  }
		  

//		  log.info("-----------------------------------------");
//		  log.info("tempObj {}",tempObj.toString());
//		  log.info("-----------------------------------------");
		  
		  videoList.add(tempObj);
		  
	  }

	  res.put("videoList",videoList);
	  
	  return res;
	  
  }

}
