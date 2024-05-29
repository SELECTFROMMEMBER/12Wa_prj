package com.wa.erp;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class NaverPage {

	  private WebDriver driver;

	  public NaverPage(WebDriver webDriver) {
	    this.driver = webDriver;
	    PageFactory.initElements(driver, this);
	  }

	  /*
	   * 네이버 뉴스탭 
	   * /html/body/div/header/div/div[2]/div/div/ul/li[6]/a
	   */
	  @FindBy(xpath = "/html/body/section/header/div[2]/div/div/div/div/div/ul/li")
	  					
	  private List<WebElement> tabs;

	  public List<WebElement> getTabs() {
	    return tabs;
	  }

	  /*
	   * 헤드라인 뉴스 List
	   */
	  @FindBy(xpath = "/html/body/div/div[2]/div[2]/div[2]/div[1]/div[1]/ul")
	  private List<WebElement> headLineList;
	  public List<WebElement> getHeadLineList() {
	    return headLineList;
	  }
	  
	   /* 
	    * 헤드라인 더보기 클릭
	    */
		  @FindBy(xpath = "/html/body/div/div[2]/div[2]/div[2]/div[1]/div[2]/a")
		  private WebElement moreHeadlinesButton; 
		  
		  public WebElement getMoreHeadlinesButton() { 
			  return moreHeadlinesButton;
		  }
	}
