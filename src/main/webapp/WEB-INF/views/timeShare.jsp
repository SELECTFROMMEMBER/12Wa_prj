<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 

<!DOCTYPE html>
<html>

<head>
<script>

//현재 채용가능 글만 보기 함수
function timeShareing(){
    // 현재 날짜 저장
    var currentDate = new Date();
    var year = currentDate.getFullYear();
    var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
    var day = ('0' + currentDate.getDate()).slice(-2);
    var formattedCurrentDate = year + month + day;

    // 현재 날짜를 기준으로 조건값 계산
    var ingValue = formattedCurrentDate; 

    $("[name='timeShareSearchForm']").find("[name='ing']").val(ingValue); 
    $(".searchBtn").click();
   }

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// 상세보기 화면으로 이동하는 
// gotimeShareDetailForm 함수 선언하기
// 매개변수로 게시판의 고유번호가 들어온다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
function gotimeShareDetailForm(b_no){
	
	//----------------------------------
	// name='boardDetailForm' 을 가진 form 태그 후손중에 
	// name='b_no' 가진 태그에 매개변수로 들어온 게시판의 고유번호를 
	// 삽입하기
	//----------------------------------
	$("[name='timeShareDetailForm']").find("[name='b_no']").val(b_no);
	//----------------------------------
	// name='buupListDetailForm' 을 가진 
	// form 태그의 action 에 설정된 URL 주소로 WAS 접속해서 
	// 얻은 새 HTML 를 웹브라우저 열기.
	// 즉 화면 이동하기.
	//---------------------------------- 
	document.timeShareDetailForm.submit();
	}

//정렬함수
function searchWithSort(sort){
	$("[name='timeShareSearchForm']").find("[name='sort']").val(sort);		
	$(".searchBtn").click();	
    }



	function pageNoClick( clickPageNo ){
		//alert(clickPageNo);
		//---------------------------------------------
		// name='selectPageNo' 를 가진 태그의 value 값에 
		// 매개변수로 들어오는 [클릭한 페이지 번호]를 저장하기
		// 즉 <input type="hidden" name="selectPageNo" value="1"> 태그에
		// value 값에 [클릭한 페이지 번호]를 저장하기
		//---------------------------------------------
		$("[name='timeShareSearchForm']").find(".selectPageNo").val(clickPageNo);
		search();	
		}
	

	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// body 태그 안의 내용을 모드 읽은 후 실행할 자스 코드 설정
	// $(function(){자스코드})
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	$(function(){
		// class=rowCntPerPage 를 가진 태그에 value 값으로 20을 넣어주기
		$(".rowCntPerPage").val("10"); 
		// search 함수 호출하기
		search();
	})	

// 	게시판 검색하는 함수 search() 선언.
// 	[검색] 버튼 클릭 시 호출되는 함수이다.
	function search(){
		//---------------------------------------------
		// 변수 timeShareSearchFormObj 선언하고 
		// name='timeShareSearchForm' 를 가진 form 태그 관리 JQuery 객체를 생성하고 저장하기
		//---------------------------------------------
		var timeShareSearchFormObj = $("[name='timeShareSearchForm']");
		var keywordObj = timeShareSearchFormObj.find(".keyword");
		
// 		var checkboxObj = timeShareSearchFormObj.find(".checkdate:checked")	
		//---------------------------------------------
		// 입력된 키워드 읽어와서 변수 keyword 에 저장하기
		// 만약에 변수 keyword 에 문자가 안들어 있으면 "" 저장하기
		// 변수 keyword 에 앞뒤공백 제거하기
		//---------------------------------------------
		var keyword = keywordObj.val();
		
		if(typeof(keyword)!='string'){ keyword=""; }
		
		keyword = $.trim(keyword);
		keywordObj.val(keyword);

		timeShareSearchFormObj.find(".rowCntPerPage").val($("select").filter(".rowCntPerPage").val() )		
		
	   
		//alert(timeShareSearchFormObj.serialize());
	
		$.ajax(
				{

					url      : "/timeShare.do"	
					,type    : "post"					
					,data    : timeShareSearchFormObj.serialize( )		
					,success : function(responseHtml){
				
						var obj = $(responseHtml);
				
						$(".timeShareListDiv").html( 
								obj.find(".timeShareListDiv").html() 
						);
						$(".pagingNos").html(
								obj.find(".pagingNos").html()
						);
						
// 						 $("body").append(
// 				                  "<textarea cols=100 rows=100>" +obj.find(".timeShareListDiv").html() +   "</textarea>"   
// 				               )
						/*$(".xxx").remove();
						$("body").prepend(
							"<textarea class=xxx cols=100 rows=100>"
							+ obj.filter(".boardListDiv").html()
							+"</textarea>"
						)*/
						
					}
					,error   : function(){
						alert("검색 실패! 관리자에게 문의 바람니다.");
					}
				}
			);
		}  // search( ) 종료부분
// ******************************************************************* //


</script>
  
</head>


<body>
    <div id="container">    
	    <%@ include file="header.jsp" %>
 
 
 
 <div class="container"  id="wrap">
     <span onclick="location.replace('/timeShare.do')">
        <h1 style="text-align: center;">프리랜서</h1> </span>

    <form name="timeShareSearchForm">
        <div style="text-align: center; margin-bottom: 20px;">
        
        
        지역
        <select name="work_place" id="work_place">
                     <option value="">지역을 선택해 주세요
                     <option value="서울특별시">서울특별시
                     <option value="인천광역시">인천광역시
                     <option value="부산광역시">부산광역시
                     <option value="경기도">경기도
                     <option value="강원도">강원도
        </select>
        
         <select name="searchType" class="searchType">
            <option value="">전체</option>
            <option value="name">이름</option>
            <option value="phone">휴대폰 번호</option>
            <option value="content">내용</option>
        </select>
         
         
           
        	<input type="text" name="keyword" class="keyword"  placeholder="검색어를 입력해주세요.">
        	<input type="button" value="검색"  class="searchBtn" onclick="search();" >	    
			<input type="hidden" name="sort"  class="sort" >
			<input type="hidden" name="selectPageNo"  class="selectPageNo"  value="1">
			<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
			<input type="hidden" name="ing"  class="ingBtn" >
	  	
		
        
       
        <span onclick="timeShareing();" >[현재 채용가능 글만 보기]</span>	    	
	   
		</form>			
       </div>
 
    <div class="timeShareListDiv">
         <form action="submit.php" method="POST">
           <table  style="border:1px solid black;margin-left:auto;margin-right:auto;">
              
              <tr>

                  <th width="50">번호</th>
              	  <th width="100">제목</th>
                  <th width="120">선호업무</th> 
                  <th width="130">주소</th>
                  <th width="130">희망 근무시간</th>
                  <th width="130">지원기간</th>
                  
                                                  
               
				<c:if test="${param.sort!='reg_date asc' and param.sort!='reg_date desc'}">
					<th style="cursor:pointer" onClick="searchWithSort('reg_date desc')">등록일</th>
				</c:if>
				
				<c:if test="${param.sort=='reg_date desc'}">
					<th  style="cursor:pointer" onClick="searchWithSort('reg_date asc')">등록일▼</th>
				</c:if>
				
				<c:if test="${param.sort=='reg_date asc'}">
					<th style="cursor:pointer" onClick="searchWithSort('')">등록일▲</th>
				</c:if>

          </tr>
              
          
          <c:forEach var="timeShare" items="${requestScope.timeShare}"  varStatus="status">
              <tr style="cursor:pointer" onClick="gotimeShareDetailForm(${timeShare.b_no});">
                 
                  <td>${requestScope.boardMap.begin_serialNo_desc-status.index}</td>
                 
                  <td align="center">${timeShare.subject}</td>
                  <td align="center">${timeShare.preferred_work}</td>
                  <td align="center">${timeShare.addr}</td>
                  <td align="center">${timeShare.start_time}시 ~ ${timeShare.end_time}시</td>
                  <td align="center">${timeShare.start_date} ~<br> ${timeShare.end_date}</td>
                  <td align="center">${timeShare.reg_date}</td>   
              </tr> 
              
                
           </c:forEach>
       
         </table>
        </div>
        
        	   <c:if test="${empty requestScope.timeShare}">
			              <center>
			              	<b>조회할 데이터가 없습니다.</b>
			              </center>       
			   </c:if>


<center> 
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
<!--- 게시판 페이징 번호 출력하기.  시작   -->
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->

<span class="pagingNos">
		<!--------------------------------------------->
		<!-- [처음] [이전] 출력하기 -->
		<!--------------------------------------------->
		<span style="cursor:pointer" 
				onClick="pageNoClick(1)">[처음]</span>
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.selectPageNo}-1)">[이전]</span>&nbsp;&nbsp;
		
		<!--------------------------------------------->
		<!--  [반복문 C코어 태그]를 사용하여 페이지 번호 출력하기 -->
		<!--------------------------------------------->
		<c:forEach var="pageNo"  begin = "${requestScope.boardMap.begin_pageNo}"    
								 end   = "${requestScope.boardMap.end_pageNo}">
			<!--------------------------------------------->
			<!--  만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 같으면  -->
			<!--------------------------------------------->
			<c:if test="${requestScope.boardMap.selectPageNo==pageNo}">
				${pageNo}
			</c:if>
			<!--------------------------------------------->
			<!--  만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 다르면  -->
			<!--------------------------------------------->
			<c:if test="${requestScope.boardMap.selectPageNo!=pageNo}">
				<span style="cursor:pointer" onClick="pageNoClick(${pageNo})">[${pageNo}]</span>
			</c:if>
		</c:forEach>&nbsp;&nbsp;
		<!--------------------------------------------->
		<!-- [다음] [마지막] 출력하기 -->
		<!--------------------------------------------->
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.selectPageNo}+1)">[다음]</span>
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.last_pageNo})">[마지막]</span>
		&nbsp;&nbsp;&nbsp;		
		<!--------------------------------------------->
		[${requestScope.timeShareListCnt}/${requestScope.timeShareAllCnt}]개 	
		<!--------------------------------------------->
		&nbsp;&nbsp;
</span>
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
<!--- 게시판 페이징 번호 출력하기.  끝   -->
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->

<select name="rowCntPerPage" class="rowCntPerPage" onChange="search()">
	<option value="10">10
	<option value="15">15
	<option value="20">20
</select>행보기 &nbsp;&nbsp;&nbsp;
	</center>
	      <c:if test="${sessionScope.member=='person'}">
          <center>
              <input type="button" value="등록"  onCLick= "location.replace('/timeShareRegForm.do')">
          </center>
          </c:if>
   </form>
   
   <form name="timeShareDetailForm" action="/timeShareDetailForm.do" method="post">
	  <input type="hidden" name="b_no" class="b_no">
	   <input type="hidden" name="p_no" value="${sessionScope.p_no}">   
	  <input type="hidden" name="resume_no" class="resume_no">
    </form>
 </div>
       
</body>
<%@ include file="footer.jsp" %> 
</html>