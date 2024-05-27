package com.wa.erp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class RegUpDelServiceImpl implements RegUpDelService{
	
	@Autowired
	private RegUpDelDAO regUpDelDAO;
	
	/*mmmmmmmmmmmmmmm게시판 등록, 수정, 삭제mmmmmmmmmmmmmmm*/
	@Override
	public BoardDTO getBoard(BoardSearchDTO boardSearchDTO) {
			BoardDTO boardDTO = this.regUpDelDAO.getBoard(boardSearchDTO);
			
			return boardDTO;
	}
	//================================================================
	//======================    게시판 등록   ===============================
	//================================================================
	@Override
	public int insertBoard(BoardDTO boardDTO) {
		
		int boardRegCnt = this.regUpDelDAO.insertBoard(boardDTO);
		
		return boardRegCnt;
	}
	//================================================================
	//======================    게시판 댓글 등록   ============================
	//================================================================
	@Override
	public int insertComment(BoardDTO boardDTO) {
		
		int CommentRegCnt = this.regUpDelDAO.insertComment(boardDTO);
		
		return CommentRegCnt;
	}
	//================================================================
	//======================    게시판 댓글 좋아요+   =========================
	//================================================================
	@Override
	public int updateRec(BoardDTO boardDTO) {
		System.out.println("1:"+boardDTO.getComment_no());
		System.out.println("1:"+boardDTO.getTable());
		System.out.println("1:"+boardDTO.getP_no());
		System.out.println("1:"+boardDTO.getB_no());
		int checkLike = this.regUpDelDAO.checkLike(boardDTO);
		if(checkLike==1) {
			return -2;
		}
		int insertLikeCnt = this.regUpDelDAO.insertLike(boardDTO);
		if(insertLikeCnt==0) {return -1;}

		int updateRecCnt = this.regUpDelDAO.updateRec(boardDTO);
		
		return updateRecCnt;
	}
	//================================================================
	//======================    게시판 댓글 싫어요-   =========================
	//================================================================
	@Override
	public int downdateRec(BoardDTO boardDTO) {
		
		int deleteLikeCnt = this.regUpDelDAO.deleteLike(boardDTO);
		if(deleteLikeCnt==0) {return -1;}

		int downdateRecCnt = this.regUpDelDAO.downdateRec(boardDTO);
		
		return downdateRecCnt;
	}
	//================================================================
	//======================    게시판 수정   ===============================
	//================================================================
	@Override
	public int updateBoard(BoardDTO boardDTO) {
		
		int boardCnt = this.regUpDelDAO.getboardCnt( boardDTO);
		if( boardCnt==0 ) { return -2; }
		
		int boardPwdCnt = this.regUpDelDAO.getboardPwdCnt( boardDTO );
		if( boardPwdCnt==0 ) { return -1; }
		
		int boardUpCnt = this.regUpDelDAO.updateBoard(boardDTO);
		
		return boardUpCnt;
	}
	
	//================================================================
	//======================    게시판 삭제   ===============================
	//================================================================
	@Override
	public int deleteBoard(BoardDTO boardDTO) {
		
		int boardCnt = this.regUpDelDAO.getboardCnt( boardDTO);
		if( boardCnt==0 ) { return boardCnt; }
		
		int boardPwdCnt = this.regUpDelDAO.getboardPwdCnt( boardDTO );
		if( boardPwdCnt==0 ) { return -1; }
		
		int boardDelCnt = this.regUpDelDAO.deleteBoard(boardDTO);
		
		return boardDelCnt;
	}
	/*mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm*/
	
	
	@Override	
public int insertGongo(BoardDTO boardDTO ) {

		int insertGonggoCnt = this.regUpDelDAO.insertGonggo(boardDTO);		
		/*
		 * int insertGonggo_fieldCnt = this.boardDAO.insertGonggo_field( boardDTO); int
		 * insertGonggo_benefitCnt = this.boardDAO.insertBenefit_code(boardDTO); int
		 * insertRole_DetailCnt = this.boardDAO.insertRole_Detail(boardDTO);
		 */
		return insertGonggoCnt;
	}


	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 프리랜서 글 등록 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int inserttimeShare( TimeShareDTO timeShareDTO ) {
		
		int timeShareRegCnt = this.regUpDelDAO.inserttimeShare( timeShareDTO );
		//----------------------------------------------
		// 1개 게시판 글 입력 적용 행의 개수 리턴하기
		//----------------------------------------------
		return timeShareRegCnt;
		}
	

	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 수정/삭제 화면에서 필요한 
	// [1개 게시판 글]을 검색 해 리턴하는 메소드 선언.
	// 매개변수로 검색할 게시판의 고유 번호가 들어온다.
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public TimeShareDTO gettimeShareForUpDel(int b_no){
		//------------------------------------------
		// [BoardDAOImpl 객체]의  getBoard 메소드를 호출하여
		// [1개 게시판 글]을 얻는다
		//------------------------------------------
		TimeShareDTO timeShareDTO  = this.regUpDelDAO.gettimeShare(b_no);
		//------------------------------------------
		// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
		//------------------------------------------
		return timeShareDTO;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int updatetimeShare(TimeShareDTO timeShareDTO)  {
		//--------------------------------------
		// 수정할 게시판의 존재 개수 얻기
		// 만약 수정할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
		//--------------------------------------
		int timeShareCnt = this.regUpDelDAO.gettimeShareCnt( timeShareDTO.getB_no() );
		if( timeShareCnt==0 ) { return timeShareCnt; }
		
		//--------------------------------------
		// 암호의 존재 개수 얻기
		// 만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1리턴하기
		//--------------------------------------
		int timeSharePwdCnt = this.regUpDelDAO.gettimeSharePwdCnt( timeShareDTO );
		if( timeSharePwdCnt==0 ) { return -1; }
		//--------------------------------------
		// 수정 실행하고 수정 적용행의 개수 얻기
		//--------------------------------------
		int timeShareUpCnt = this.regUpDelDAO.updatetimeShare( timeShareDTO );
		//--------------------------------------
		// 수정 적용행의 개수 리턴하기
		//--------------------------------------
		return timeShareUpCnt;
     	}
	
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
public int deletetimeShare(TimeShareDTO timeShareDTO)  {
	//--------------------------------------
	// 삭제할 게시판의 존재 개수 얻기
	// 만약 삭제할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
	//--------------------------------------
	int timeShareCnt = this.regUpDelDAO.gettimeShareCnt( timeShareDTO.getB_no() );
	if( timeShareCnt==0 ) { return timeShareCnt; }
	//--------------------------------------
	// 암호의 존재 개수 얻기
	// 만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1리턴하기
	//--------------------------------------
	int timeSharePwdCnt = this.regUpDelDAO.gettimeSharePwdCnt( timeShareDTO );
	if( timeSharePwdCnt==0 ) { return -1; }
  
	//--------------------------------------
	// 삭제 실행하고 삭제 적용행의 개수 얻기
	//--------------------------------------
	int timeShareDelCnt = this.regUpDelDAO.deletetimeShare( timeShareDTO );
	//--------------------------------------
	// 수정 적용행의 개수 리턴하기
	//--------------------------------------
	return timeShareDelCnt;
	}
	
	//=================================================================
	//부업 등록, 수정, 삭제
	//=================================================================
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// 수정/삭제 화면에서 필요한 
// [1개 게시판 글]을 검색 해 리턴하는 메소드 선언.
// 매개변수로 검색할 게시판의 고유 번호가 들어온다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
public BuupDTO  getbuupForUpDel(int b_no){
	//------------------------------------------
	// [BoardDAOImpl 객체]의  getbuup 메소드를 호출하여
	// [1개 게시판 글]을 얻는다
	//------------------------------------------
	BuupDTO buupDTO  = this.regUpDelDAO.getbuup(b_no);
	//------------------------------------------
	// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
	//------------------------------------------
	return buupDTO;
	}	

	
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// [1개 게시판] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
public int updatebuup(BuupDTO buupDTO)  {
	//--------------------------------------
	// 수정할 게시판의 존재 개수 얻기
	// 만약 수정할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
	//--------------------------------------
	int buupCnt = this.regUpDelDAO.getbuupCnt( buupDTO.getB_no() );
	if( buupCnt==0 ) { return buupCnt; }
	
	//--------------------------------------
	// 암호의 존재 개수 얻기
	// 만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1리턴하기
	//--------------------------------------
	int buupPwdCnt = this.regUpDelDAO.getbuupPwdCnt( buupDTO );
	if( buupPwdCnt==0 ) { return -1; }
	//--------------------------------------
	// 수정 실행하고 수정 적용행의 개수 얻기
	//--------------------------------------
	int buupUpCnt = this.regUpDelDAO.updatebuup( buupDTO );
	//--------------------------------------
	// 수정 적용행의 개수 리턴하기
	//--------------------------------------
	return buupUpCnt;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int deletebuup(BuupDTO buupDTO)  {
	//--------------------------------------
	// 삭제할 게시판의 존재 개수 얻기
	// 만약 삭제할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
	//--------------------------------------
	int buupCnt = this.regUpDelDAO.getbuupCnt( buupDTO.getB_no() );
	if( buupCnt==0 ) { return buupCnt; }
	//--------------------------------------
	// 암호의 존재 개수 얻기
	// 만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1리턴하기
	//--------------------------------------
	int buupPwdCnt = this.regUpDelDAO.getbuupPwdCnt( buupDTO );
	if( buupPwdCnt==0 ) { return -1; }
  
	//--------------------------------------
	// 삭제 실행하고 삭제 적용행의 개수 얻기
	//--------------------------------------
	int buupDelCnt = this.regUpDelDAO.deletebuup( buupDTO );
	//--------------------------------------
	// 수정 적용행의 개수 리턴하기
	//--------------------------------------
	return buupDelCnt;
	}

	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 부업 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int insertbuup(BuupDTO buupDTO) {
	
	int buupRegCnt = this.regUpDelDAO.insertbuup(buupDTO);
	//----------------------------------------------
	// 1개 게시판 글 입력 적용 행의 개수 리턴하기
	//----------------------------------------------
	return buupRegCnt;
	}
				
				
				//기업리뷰 작성
	@Override
	public int upReview(BoardDTO boardDTO) {
		
		//----------------------------------------------
		// BoardDAOImpl 객체의  
			// insertBoard 메소드 호출하여 
			// 게시판 글 입력 후 입력 적용 행의 개수 얻기
		//----------------------------------------------
		int reviewRegCnt = this.regUpDelDAO.upReview( boardDTO );

		//----------------------------------------------
		// 1개 게시판 글 입력 적용 행의 개수 리턴하기
		//----------------------------------------------
		return reviewRegCnt;
	   }	
	
	//이력서 등록
	public int insertResume(BoardDTO boardDTO ) {
		int insertResumeCnt = this.regUpDelDAO.insertResume(boardDTO);			
		int insertAwardsCnt = this.regUpDelDAO.insertAwards(boardDTO); 
			if(insertAwardsCnt==0) {return -1;}
			
		 int insertEducationCnt = this.regUpDelDAO.insertEducation(boardDTO); 
		 	if(insertEducationCnt==0) {return -2;}
		 	
		 int insertCareerCnt = this.regUpDelDAO.insertCareer(boardDTO); 
		 	if(insertCareerCnt==0) {return -3;}
		 	
		 int insertPerson_licenseCnt = this.regUpDelDAO.insertPerson_license(boardDTO);
		 	if(insertPerson_licenseCnt==0) {return -4;}
		 	if(boardDTO.getSkill_code()!=null) {
		 int insertSkillCnt = this.regUpDelDAO.insertSkill_Code(boardDTO);
		 	if(insertSkillCnt==0) {return -5;}
		 	};
		 return insertResumeCnt;
	}

	
	
	
	
	// 개인정보 수정
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 수정/삭제 화면에서 필요한 
		// [회원정보]을 검색 해 리턴하는 메소드 선언.
		// 매개변수로 검색할 회원의 고유 번호가 들어온다.
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public MypageDTO  getPrivacyForUpDel(int p_no){
			//------------------------------------------
			// [BoardDAOImpl 객체]의  getMyPrivacy 메소드를 호출하여
			// 회원정보을 얻는다
			//------------------------------------------
			MypageDTO mypageDTO  = this.regUpDelDAO.getPrivacy(p_no);
			//------------------------------------------
			// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
			//------------------------------------------
			return mypageDTO;
			}	

	@Override
	public int deleteReview(BoardDTO boardDTO) {
	
		//--------------------------------------
		// 수정 실행하고 수정 적용행의 개수 얻기
		//--------------------------------------
		int boardDelCnt = this.regUpDelDAO.deleteReview( boardDTO );
		//--------------------------------------
		// 수정 적용행의 개수 리턴하기
		//--------------------------------------
		return boardDelCnt;
	}
	@Override
	public int updateReview(BoardDTO boardDTO) {

		
		int reviewUpdateCnt = this.regUpDelDAO.updateReview(boardDTO);
		
		return reviewUpdateCnt;
	}

		
			
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// [1개 게시판] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public int updatePrivacy(MypageDTO mypageDTO){
			//--------------------------------------
			// 수정할 게시판의 존재 개수 얻기
			// 만약 수정할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
			//--------------------------------------
	     	int PrivacyCnt = this.regUpDelDAO.getPrivacyCnt( mypageDTO.getP_no( )  );
			if( PrivacyCnt==0 ) { return PrivacyCnt; }
			
			//--------------------------------------
			// 암호의 존재 개수 얻기
			// 만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1리턴하기
			//--------------------------------------
			int PrivacyPwdCnt = this.regUpDelDAO.getPrivacyPwdCnt( mypageDTO );
			if( PrivacyPwdCnt==0 ) { return -1; }
			//--------------------------------------
			// 수정 실행하고 수정 적용행의 개수 얻기
			//--------------------------------------
			int personalUpCnt = this.regUpDelDAO.updatePrivacy( mypageDTO );
			//--------------------------------------
			// 수정 적용행의 개수 리턴하기
			//--------------------------------------
			return personalUpCnt;
			}
		
	
	//관심기업 등록
	public int insertLikeCompany(BoardDTO boardDTO) {
		
		int updaterec = this.regUpDelDAO.updateCompanyRec(boardDTO);
		if(updaterec==0) {
			return 3;
		}
		int insertLikeCnt = this.regUpDelDAO.insertLikeCompany(boardDTO);

		return insertLikeCnt;
	}

	//관심기업 해제
	public int deleteLikeCompany(BoardDTO boardDTO) {
		
		int downdaterec = this.regUpDelDAO.downdateCompanyRec(boardDTO);
		if(downdaterec==0) {
			return 3;
		}
		int deleteLikeCnt = this.regUpDelDAO.deleteLikeCompany(boardDTO);
		
		return deleteLikeCnt;
	}
	
	//댓글 수정
	public int updateComment(BoardDTO boardDTO) {
		int updateComment = this.regUpDelDAO.updateComment(boardDTO);
		
		return updateComment;
	}

	//댓글 삭제
	public int deleteComment(BoardDTO boardDTO) {
		int deleteComment = this.regUpDelDAO.deleteComment(boardDTO);
		
		int deleteLike = this.regUpDelDAO.deleteLikecomment(boardDTO);
		
		return deleteComment;
	}
	@Override
	public int insertNotice(BoardDTO boardDTO) {
		int noticeRegCnt = this.regUpDelDAO.insertNotice(boardDTO);
		
		return noticeRegCnt;
	}
	@Override
	public int updateNotice(BoardDTO boardDTO) {
		int updateNotice = this.regUpDelDAO.updateNotice(boardDTO);
		
		return updateNotice;
		
	}
	@Override
	public int deleteNotice(BoardDTO boardDTO) {
		int deleteNotice = this.regUpDelDAO.deleteNotice(boardDTO);
		
		
		return deleteNotice;
	}
	@Override
	public int deleteSelectPostCnt(BoardDTO boardDTO) {
	int deleteSelectPost = this.regUpDelDAO.deleteSelectPost(boardDTO);
		
		
		return deleteSelectPost;
	}

	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int deletePrivacy(MypageDTO mypageDTO) {
		//--------------------------------------
		// 삭제할 게시판의 존재 개수 얻기
		// 만약 삭제할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
		//--------------------------------------
		int PrivacyCnt = this.regUpDelDAO.getPrivacyCnt( mypageDTO.getP_no() );
		if( PrivacyCnt==0 ) { return PrivacyCnt; }
		//--------------------------------------
		// 암호의 존재 개수 얻기
		// 만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1리턴하기
		//--------------------------------------
		int PrivacyPwdCnt = this.regUpDelDAO.getPrivacyPwdCnt( mypageDTO );
		if( PrivacyPwdCnt==0 ) { return -1; }
	  
		//--------------------------------------
		// 삭제 실행하고 삭제 적용행의 개수 얻기
		//--------------------------------------
		int PrivacyDelCnt = this.regUpDelDAO.deletePrivacy( mypageDTO );
		//--------------------------------------
		// 수정 적용행의 개수 리턴하기
		//--------------------------------------
		return PrivacyDelCnt;
		}
	
	
	
	//=====================================
	//(이력서 수정,삭제)
	//=====================================
         	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// 수정/삭제 화면에서 필요한 
			// [이력서]을 검색 해 리턴하는 메소드 선언.
			// 매개변수로 검색할 이력서의 고유 번호가 들어온다.
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			public BoardDTO  getResumeForUpDel(int resume_no){
				//------------------------------------------
				// [BoardDAOImpl 객체]의  getResume 메소드를 호출하여
				// 이력서 정보를 얻는다
				//------------------------------------------
				BoardDTO boardDTO  = this.regUpDelDAO.getResume(resume_no);
				//------------------------------------------
				// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
				//------------------------------------------
				return boardDTO;
				}	

			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// [1개 이력서] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			public int updateResume(BoardDTO boardDTO){
				//--------------------------------------
				// 수정할 이력서의 존재 개수 얻기
				// 만약 수정할 이력서의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
				//--------------------------------------
		     	int ResumeCnt = this.regUpDelDAO.getResumeCnt( boardDTO.getResume_no( )  );
				if( ResumeCnt==0 ){ return ResumeCnt; }
				//--------------------------------------
				// 암호의 존재 개수 얻기
				// 만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1리턴하기
				//--------------------------------------
				//int ResumePwdCnt = this.regUpDelDAO.getResumePwdCnt (boardDTO );
			    //if( ResumePwdCnt==0 ) { return -1; }
				//--------------------------------------
				// 수정 실행하고 수정 적용행의 개수 얻기
				//--------------------------------------
				int ResumeUpCnt = this.regUpDelDAO.updateResume( boardDTO );
				
				ResumeUpCnt = this.regUpDelDAO.updateAwards(boardDTO);
				ResumeUpCnt = this.regUpDelDAO.updateEducation(boardDTO);
				ResumeUpCnt = this.regUpDelDAO.updateCareer(boardDTO);
				if (ResumeUpCnt>0) {ResumeUpCnt=1;  }
				
				ResumeUpCnt = this.regUpDelDAO.updatePerson_license(boardDTO);
				if (ResumeUpCnt>0) {ResumeUpCnt=1;  }
				
			    ResumeUpCnt = this.regUpDelDAO.deletePersonSkill(boardDTO);
			    if (ResumeUpCnt>0) {ResumeUpCnt=1;  }
			   
                ResumeUpCnt = this.regUpDelDAO.insertSkill_Code1(boardDTO);
                if (ResumeUpCnt>0) {ResumeUpCnt=1;  }
				//--------------------------------------
				// 수정 적용행의 개수 리턴하기
				//--------------------------------------
				return ResumeUpCnt;
				}
			
	
			
		
			
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// [1개 이력서] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public int deleteResume(BoardDTO boardDTO) {
			//--------------------------------------
			// 삭제할 게시판의 존재 개수 얻기
			// 만약 삭제할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
			//--------------------------------------
			int ResumeCnt = this.regUpDelDAO.getResumeCnt( boardDTO.getResume_no() );
			if( ResumeCnt==0 ) { return ResumeCnt; }
			//------------------------------------------------------
			// 삭제 실행하고 삭제 적용행의 개수 얻기
			//------------------------------------------------------
			int ResumeDelCnt = this.regUpDelDAO.deleteResume( boardDTO );
			
			ResumeDelCnt = this.regUpDelDAO.deleteEducation(boardDTO);
			ResumeDelCnt = this.regUpDelDAO.deleteAwards(boardDTO);
			ResumeDelCnt = this.regUpDelDAO.deleteCareer(boardDTO);
			if (ResumeDelCnt>0) {ResumeDelCnt=1;  }
			
			ResumeDelCnt = this.regUpDelDAO.deletePersonSkill(boardDTO);
			if (ResumeDelCnt>0) {ResumeDelCnt=1;  }
			
			ResumeDelCnt = this.regUpDelDAO.deletePerson_license(boardDTO);	
			if (ResumeDelCnt>0) {ResumeDelCnt=1;  }
			
			//--------------------------------------
			// 삭제 적용행의 개수 리턴하기
			//--------------------------------------
			return ResumeDelCnt;
			}
		
		@Override
		public List<BoardDTO> getSkillList(int resume_no) {
			List<BoardDTO> skillList = this.regUpDelDAO.getSkillList(resume_no);
			return skillList;
		}

	
}
