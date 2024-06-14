<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.wa.erp.BoardDTO"%>

<!DOCTYPE html>
<html>

<head>
<style>
	    /* Form container */
    .form-container {
        text-align: center;
        margin-bottom: 20px;
    }

    /* Text input field */
    .keyword {
        padding: 5px;
        border-radius: 5px;
        border: 1px solid #ccc;
        margin-right: 10px;
        width: 200px; /* Adjust width as needed */
    }

    /* Search button */
    .searchBtn {
        padding: 5px 20px;
        border-radius: 5px;
        border: none;
        background-color: #007bff;
        color: #fff;
        cursor: pointer;
    }

    /* Search button hover effect */
    .searchBtn:hover {
        background-color: #0056b3;
    }

    /* Select box */
    select {
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
        margin-right: 10px;
    }
    
</style>
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

	       $("[name='prjSearchForm']").find("[name='ing']").val(ingValue); 
	       $(".searchBtn").click();
	      }

	
	function searchWithSort(sort){
		
		$("[name='prjSearchForm']").find("[name=sort]").val(sort);
		
		$(".searchBtn").click();
		
	}
	
	function goBoardDetailForm(prj_no){
		
	 		$("[name='prjDetailForm']").find("[name='prj_no']").val(prj_no);
	 		
	 		document.prjDetailForm.submit();
		}
	
	function search(){
		
		var prjSearchFormObj = $("[name=prjSearchForm]");
		
		var keywordObj = prjSearchFormObj.find(".keyword");
		
		var keyword = keywordObj.val();
		
		if(typeof(keyword)!='string'){keyword = "";}
		keyword = $.trim(keyword);
		keywordObj.val(keyword);
		
		prjSearchFormObj.find(".rowCntPerPage").val( 
				$("select").filter(".rowCntPerPage").val()
		)
		
		$.ajax(
				{
				url : "/prj.do"
				, type : "post"
				, data : prjSearchFormObj.serialize()
				, success : function(responseHtml){
					var obj = $(responseHtml);
					$(".prjListDiv").html(
							obj.find(".prjListDiv").html()		
					);
					$(".pagingNos").html(
							obj.find(".pagingNos").html()		
					);
					
				}
				,error : function(){
					alert("검색 실패! 관리자에게 문의 바랍니다.")
				}
			}
		)
	}
	
	function pageNoClick( clickPageNo ){
		$("[name='prjSearchForm']").find(".selectPageNo").val(clickPageNo);
		search();
	}
	
	
	</script>

</head>
<body>
	<div id="container">
		<%@ include file="header.jsp"%>




		</br>
		<div id="wrap" class="container">
			<h1 style="text-align: center;">프로젝트</h1>

			<form name="prjSearchForm" onsubmit="return false">
				<div style="text-align: center; margin-bottom: 20px;">
					<select name="project_type" class="project_type">
						<option value="">모두</option>
						<option value="개인">개인</option>
						<option value="공모전">공모전</option>
					</select> <input type="text" name="keyword" class="keyword"> <input
						type="button" value=" 검색 " class="searchBtn" onclick="search()">
					<br> <span onclick="timeShareing();">[진행중인 프로젝트만 보기]</span>
					<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
					<input type="hidden" name="ing" class="ing">
					<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
					<input type="hidden" name="sort" class="sort">
					<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
					<input type="hidden" name="selectPageNo" class="selectPageNo"
						value="1">
					<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
					<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
					<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
				</div>
			</form>

			<div class="prjListDiv">
				<form action="submit.php" method="POST">
					<table
						style="border: 1px solid black; margin-left: auto; margin-right: auto;">

						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>종류</th>
							<th>기간</th>
							<c:if
								test="${param.sort!='reg_date asc' and param.sort!='reg_date desc'}">
								<th style="cursor: pointer"
									onClick="searchWithSort('reg_date desc')">등록일</th>
							</c:if>
							<c:if test="${param.sort=='reg_date desc'}">
								<th style="cursor: pointer"
									onClick="searchWithSort('reg_date asc')">등록일▼</th>
							</c:if>
							<c:if test="${param.sort=='reg_date asc'}">
								<th style="cursor: pointer" onClick="searchWithSort('')">등록일▲</th>
							</c:if>

							<c:if
								test="${param.sort!='read_count asc' and param.sort!='read_count desc'}">
								<th width="100" style="cursor: pointer"
									onClick="searchWithSort('read_count desc')"><center>조회수</center></th>
							</c:if>

							<!-- 만약 파명 "sort" 의 파값이 'reg_date desc' 면 -->
							<!-- 즉 정렬 의지가 'reg_date desc' 면 -->
							<c:if test="${param.sort=='read_count desc'}">
								<th width="100" style="cursor: pointer"
									onClick="searchWithSort('read_count asc')">조회수▼</th>
							</c:if>

							<!-- 만약 파명 "sort" 의 파값이 'reg_date asc' 면 -->
							<!-- 즉 정렬 의지가 'reg_date asc' 면 -->
							<c:if test="${param.sort=='read_count asc'}">
								<th width="100" style="cursor: pointer"
									onClick="searchWithSort('')">조회수▲</th>
							</c:if>



						</tr>

						<c:forEach var="prj" items="${requestScope.prjList}"
							varStatus="status">
							<tr style="cursor: pointer"
								onCLick="goBoardDetailForm(${prj.prj_no})">
								<!-- 미안해요 여기 아직 안고침 goBoard... -->
								<td align="center">
									${requestScope.boardMap.begin_serialNo_desc-status.index}</td>
								<td align="center">${prj.subject}</td>
								<td align="center">${prj.project_type}</td>
								<td align="center">${prj.start_time} ~ ${prj.end_time}</td>
								<td align="center">${prj.reg_date}</td>
								<td align="center">${prj.read_count}</td>
							</tr>
						</c:forEach>



					</table>



				</form>

				<c:if test="${empty prjList}">
					<center>조회할 데이터가 없습니다.</center>
				</c:if>
			</div>

			<br>
			<center>

				<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
				<!--- 게시판 페이징 번호 출력하기.  시작   -->
				<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
				<span class="pagingNos"> <!--------------------------------------------->
					<!-- [처음] [이전] 출력하기 --> <!--------------------------------------------->
					<span style="cursor: pointer" onClick="pageNoClick(1)">[처음]</span>
					<span style="cursor: pointer"
					onClick="pageNoClick(${requestScope.boardMap.selectPageNo}-1)">[이전]</span>&nbsp;&nbsp;

					<!---------------------------------------------> <!--  [반복문 C코어 태그]를 사용하여 페이지 번호 출력하기 -->
					<!---------------------------------------------> <c:forEach
						var="pageNo" begin="${requestScope.boardMap.begin_pageNo}"
						end="${requestScope.boardMap.end_pageNo}">
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
							<span style="cursor: pointer" onClick="pageNoClick(${pageNo})">[${pageNo}]</span>
						</c:if>
					</c:forEach>&nbsp;&nbsp; <!---------------------------------------------> <!-- [다음] [마지막] 출력하기 -->
					<!---------------------------------------------> <span
					style="cursor: pointer"
					onClick="pageNoClick(${requestScope.boardMap.selectPageNo}+1)">[다음]</span>
					<span style="cursor: pointer"
					onClick="pageNoClick(${requestScope.boardMap.last_pageNo})">[마지막]</span>
					&nbsp;&nbsp;&nbsp; <!--------------------------------------------->
					[${requestScope.prjListCnt}/${requestScope.prjListAllCnt}] 개 <!--------------------------------------------->
					&nbsp;&nbsp;
				</span>
				<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
				<!--- 게시판 페이징 번호 출력하기.  끝   -->
				<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
				<select name="rowCntPerPage" class="rowCntPerPage"
					onChange="search()">
					<option value="10">10
					<option value="15">15
					<option value="20">20
				</select> 행보기 &nbsp;&nbsp;&nbsp;
			</center>

			<c:if test="${sessionScope.member=='person' }">
				<center>
					</br> <input type="button" value=" 등록 "
						onCLick="location.replace('/prjRegForm.do')">
				</center>
			</c:if>



		</div>


		<!-- 디테일로 들어가기 위한 히든 -->
		<form name="prjDetailForm" action="/prjDetailForm.do" method="post">
			<input type="hidden" name="prj_no">
		</form>
	</div>
</body>
<%@ include file="footer.jsp"%>
</html>
