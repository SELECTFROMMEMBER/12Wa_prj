package com.wa.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class GonggoController {

	@Autowired
	private GonggoService gonggoService;
	

	@RequestMapping( value ="/gongGoList.do")

	// 공고 리스트
	public ModelAndView gongGoList(

			BoardSearchDTO boardSearchDTO) {

		int gonggoListAllCnt = this.gonggoService.getGonggoListAllCnt(boardSearchDTO);

		int gonggoListCnt = this.gonggoService.getGonggoListCnt(boardSearchDTO);

		Map<String, Integer> boardMap = Util.getPagingMap(boardSearchDTO.getSelectPageNo() // 선택한 페이지 번호
				, boardSearchDTO.getRowCntPerPage() // 페이지 당 보여줄 검색 행의 개수
				, gonggoListCnt // 검색결과 개수
		);

		boardSearchDTO.setSelectPageNo((int) boardMap.get("selectPageNo"));
		boardSearchDTO.setRowCntPerPage((int) boardMap.get("rowCntPerPage"));
		boardSearchDTO.setBegin_rowNo((int) boardMap.get("begin_rowNo"));
		boardSearchDTO.setEnd_rowNo((int) boardMap.get("end_rowNo"));

		/*
		 * System.out.print("시작"+boardSearchDTO.getBegin_rowNo());
		 * System.out.print("끝"+boardSearchDTO.getEnd_rowNo());
		 */

		List<GonggoDTO> gonggoList = this.gonggoService.getgongGoList(boardSearchDTO);

		ModelAndView mav = new ModelAndView();

		mav.addObject("gonggoList", gonggoList);
		mav.addObject("gonggoListAllCnt", gonggoListAllCnt);

		mav.addObject("gonggoListCnt", gonggoListCnt);
		mav.addObject("boardMap", boardMap);

		mav.setViewName("gongGoList.jsp");

		return mav;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// /gonggo 디테일
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
@RequestMapping(value="/gonggoDetailForm.do")
public ModelAndView gonggoDetailForm(
		@RequestParam(value="g_no") int g_no
		) {
	

	GonggoDTO gonggoDTO = this.gonggoService.getgonggoDetailForm(g_no);
	
	ModelAndView mav = new ModelAndView();
	
	mav.addObject("GonggoDTO", gonggoDTO);
	
	mav.setViewName("gongGoLocationListDetail.jsp");
	
	return mav;
}
// 공고 수정
@RequestMapping( value ="/gongGoRegForm.do")
public ModelAndView gongGoRegForm(
		BoardSearchDTO boardSearchDTO
		) {
	
	ModelAndView mav = new ModelAndView();
	
	mav.setViewName("gongGoRegForm.jsp");
	return mav;
}

//공고등록 페이지
	@RequestMapping( 
		value="/gongGoReg.do" 
		,method=RequestMethod.POST
		,produces="application/json;charset=UTF-8"
)
@ResponseBody
public Map<String,String> gongGoRegProc (  
		GonggoDTO  gonggoDTO
){
	
	Map<String,String> resultMap = new HashMap<String,String>();
	
	int gongGoRegCnt = this.gonggoService.insertGongo(gonggoDTO);
	
	resultMap.put( "result", gongGoRegCnt+"" );
	
	return resultMap;
}
	
	// 공고 수정/삭제페이지
	@RequestMapping(value = "/gonggoUpDelForm.do")
	
	public ModelAndView gonggoUpDelForm(

			@RequestParam(value = "g_no") int g_no) {
		
			System.out.println(g_no);
		GonggoDTO gonggoDTO = this.gonggoService.getGonggo(g_no);

			System.out.println("::"+gonggoDTO.getCareer());
			System.out.println("::"+gonggoDTO.getBenefit_code1());
			System.out.println("::"+gonggoDTO.getSalary());
			System.out.println("::"+gonggoDTO.getPosition_code1());
		ModelAndView mav = new ModelAndView();

		mav.addObject("gonggoDTO", gonggoDTO);

		mav.setViewName("gongGoUpDelForm.jsp");

		return mav;
	}
	
	// 공고 삭제
	@RequestMapping( 
			value="/gonggoDelProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public Map<String,String> gonggoDelProc( 
			GonggoDTO gonggoDTO	
	) {
		Map<String,String> resultMap = new HashMap<String,String>();
		
		int gonggoDelCnt = this.gonggoService.deleteFromGonggo(gonggoDTO);

		resultMap.put( "result", gonggoDelCnt+"" );
		
		return resultMap;
	}
	
	// 공고 수정
	@RequestMapping(value = "/gonggoUpProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> gonggoUpProc(

			GonggoDTO gonggoDTO) {

		Map<String, String> resultMap = new HashMap<String, String>();

		int gonggoUpCnt = this.gonggoService.updateGonggo(gonggoDTO);

		resultMap.put("result", gonggoUpCnt + "");

		return resultMap;
	}
	
	// 공고 이력서 지원		
	@RequestMapping(value="/gonggoSupportProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
			)
	@ResponseBody
	public Map<String,String> gonggoSupport(
			GonggoDTO  gonggoDTO
			) {
		
	
		Map<String,String> resultMap = new HashMap<String,String>();
		
		int gonggoSupportCnt = this.gonggoService.gonggoSupport(gonggoDTO);

		resultMap.put( "result", gonggoSupportCnt+"" );
		
		return resultMap;
	}	
}
