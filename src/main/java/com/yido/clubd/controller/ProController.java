package com.yido.clubd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.yido.clubd.common.service.CommonService;
import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.model.CdCommon;
import com.yido.clubd.model.CoPlace;
import com.yido.clubd.model.DrMsCoInfo;
import com.yido.clubd.model.MemberVO;
import com.yido.clubd.model.ProVO;
import com.yido.clubd.service.CoPlaceService;
import com.yido.clubd.service.DrMsCoInfoService;
import com.yido.clubd.service.MemberService;
import com.yido.clubd.service.ProService;

import lombok.extern.slf4j.Slf4j;

/**
 * 프로
 * 
 * @author YOO
 *
 */
@Controller
@Slf4j
@RequestMapping("/pro")
public class ProController {

	@Autowired
	private ProService proService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private CommonService commonService;

	@Autowired
	private CoPlaceService coPlaceService;

	@Autowired
	private DrMsCoInfoService drMsCoInfoService;

	/**
	 * 프로 목록 페이지
	 * 
	 * @param req
	 * @return
	 */
	@RequestMapping("/proMain")
	public String goProMain(Model model, HttpServletResponse res) {
		try {
			List<MemberVO> proList = memberService.selectProList();
			List<MemberVO> ambassadorList = memberService.selectAmbassadorList();

			if (proList.isEmpty()) {
				throw new Exception("조회 가능한 프로가 없습니다");
			}
			model.addAttribute("result", true);
			model.addAttribute("proList", proList);
			model.addAttribute("ambassadorList", ambassadorList);
		} catch (Exception e) {
			model.addAttribute("result", false);
			model.addAttribute("message", e.getMessage());
		}
		return "/pro/proMain";
	}

	/**
	 * 프로 상세 페이지
	 * 
	 * @param model
	 * @param req
	 * @param msNum
	 * @return
	 */
	@RequestMapping("/proDetail")
	public String goProDetail(Model model, HttpServletRequest req, @RequestParam String msNum) {
		Map<String, Object> map = new HashMap<>();
		map.put("msNum", msNum);

		MemberVO member = memberService.selectMember(map);
		MemberVO proProfile = memberService.selectProfileImg(map);

		List<ProVO> proNoticeList = proService.selectProNoticeOpenList(map);
		List<ProVO> proLicList = proService.selectProLicenseList(map);
		List<ProVO> proImgList = proService.selectProImageList(map);

		model.addAttribute("proInfo", member);
		model.addAttribute("proProfile", proProfile);

		model.addAttribute("proNoticeList", proNoticeList);
		model.addAttribute("proLicList", proLicList);
		model.addAttribute("proImgList", proImgList);

		return "/pro/proDetail";
	}

	/**
	 * 프로 정보수정 페이지
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/proForm")
	public String goProForm(Model model, HttpSession session) throws Exception {
		CdCommon cdCommon = new CdCommon();
		cdCommon.setCoDiv("001");

		cdCommon.setCdDivision("025");
		List<CdCommon> jobList = commonService.getCommonCodeList(cdCommon);
		cdCommon.setCdDivision("018");
		List<CdCommon> licenseList = commonService.getCommonCodeList(cdCommon);
		cdCommon.setCdDivision("220");
		List<CdCommon> msArea1List = commonService.getCommonCodeList(cdCommon);

		List<CoPlace> placeList = coPlaceService.selectPlaceList();

		SessionVO member = (SessionVO) session.getAttribute("msMember");
		String msNum = member.getMsNum();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msNum", msNum);

		MemberVO proProfile = memberService.selectProfileImg(map);
		List<MemberVO> carList = memberService.selectMemberCarList(msNum);
		List<ProVO> noticeList = proService.selectProNoticeList(map);

		List<ProVO> proLicList = proService.selectProLicenseList(map);
		DrMsCoInfo drMsInfo = drMsCoInfoService.selectFirstPick(msNum);

		/* 공통 코드 */
		model.addAttribute("jobList", jobList);
		model.addAttribute("licenseList", licenseList);
		model.addAttribute("msArea1List", msArea1List);
		model.addAttribute("placeList", placeList);

		/* 프로 프로필 정보 */
		model.addAttribute("proProfile", proProfile);
		model.addAttribute("carList", carList);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("proLicList", proLicList);

		if (drMsInfo != null) {
			model.addAttribute("msFirstPick", drMsInfo.getCoDiv());
		} else {
			model.addAttribute("msFirstPick", "");
		}

		return "/pro/proForm";
	}

	/**
	 * 프로 정보수정 저장
	 * 
	 * @param req
	 * @param params
	 * @return map
	 */
	@RequestMapping("/saveProForm")
	@ResponseBody
	public Map<String, Object> saveProForm(HttpSession session, HttpServletRequest req,
			@RequestParam HashMap<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		SessionVO msMember = (SessionVO) req.getSession().getAttribute("msMember");

		try {
			// 레슨프로(01)
			if (msMember.getMsLevel().equals("01")) {
				params.put("msStatus", "Y");
				// 소속프로(00), 앰배서더(02)는 승인 필요
			} else {
				// 230713 운영측 요청으로 수정 - YMS
				// params.put("msStatus", "U");
				params.put("msStatus", "Y");
			}
			memberService.updateMember(params);
			memberService.saveMemberCar(params);
			memberService.saveFirstPick(params);

			proService.saveProNotice(params);
			proService.saveProLicense(params);

			// 관리자에게 제출 알림 문자 전송
			// 230713 운영측 요청으로 수정 - YMS
			// if(params.get("msStatus") == "U") {
			if (!msMember.getMsLevel().equals("01")) {
				CdCommon cdCommon = new CdCommon();
				cdCommon.setCoDiv("001");
				cdCommon.setCdDivision("A31");
				cdCommon.setCdType("1");
				List<CdCommon> managerList = commonService.getCommonCodeList(cdCommon);

				for (CdCommon item : managerList) {
					params.put("coDiv", "001");
					params.put("tplCd", "10029");
					params.put("msPhone", item.getCdTitle4());
					params.put("msId", msMember.getMsId());
					params.put("msName", msMember.getMsName());

					commonService.sendSms(params);
				}
			}

			msMember = memberService.selectMsSession(params);
			session.setAttribute("msMember", msMember);

			map.put("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", false);
			map.put("message", "수정중 오류가 발생하였습니다.");
		}

		return map;
	}

	/**
	 * 프로 프로필 이미지 업로드
	 * 
	 * @param mreq
	 * @param params
	 * @return map
	 */
	@RequestMapping("/uploadProfileImg")
	@ResponseBody
	public Map<String, Object> uploadProfileImg(MultipartHttpServletRequest mreq,
			@RequestParam Map<String, Object> params) throws IllegalStateException, IOException {

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			memberService.uploadProfileImg(params, mreq);
			map.put("result", true);

		} catch (Exception e) {
			map.put("result", false);
			map.put("message", "파일 업로드중 오류가 발생하였습니다.");
			e.printStackTrace();
		}
		return map;
	}

	@RequestMapping(value = "/deleteProfileImg")
	@ResponseBody
	public Map<String, Object> deleteProfileImg(@RequestParam Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			memberService.deleteProfileImg(params);
			map.put("result", true);
		} catch (Exception e) {
			map.put("result", false);
			map.put("message", "파일 삭제 중 오류가 발생했습니다.");
		}
		return map;
	}

	/**
	 * 프로 갤러리 페이지
	 * 
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/proGallery")
	public String goProGallery(Model model, HttpSession session, @RequestParam Map<String, Object> params) {
		SessionVO member = (SessionVO) session.getAttribute("msMember");
		params.put("msNum", member.getMsNum());

		List<ProVO> galleryList = proService.selectProImageList(params);
		model.addAttribute("galleryList", galleryList);
		return "/pro/proGallery";
	}

	/**
	 * 프로 갤러리 이미지 업로드
	 * 
	 * @param mreq
	 * @param params
	 * @return map
	 */
	@RequestMapping("/uploadGalleryImg")
	@ResponseBody
	public Map<String, Object> uploadGalleryImg(MultipartHttpServletRequest mreq,
			@RequestParam Map<String, Object> params) throws IllegalStateException, IOException {

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			proService.uploadGalleryImg(params, mreq);
			map.put("result", true);

		} catch (Exception e) {
			map.put("result", false);
			map.put("message", "파일 업로드중 오류가 발생하였습니다.");
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 프로 갤러리 영상 업로드
	 * 
	 * @param mreq
	 * @param params
	 * @return map
	 */
	@RequestMapping("/uploadGalleryVideo")
	@ResponseBody
	public Map<String, Object> uploadGalleryVideo(MultipartHttpServletRequest mreq,
			@RequestParam Map<String, Object> params) throws IllegalStateException, IOException {

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			map = proService.uploadGalleryVideo(params, mreq);

		} catch (Exception e) {
			map.put("result", false);
			map.put("message", "파일 업로드중 오류가 발생하였습니다.");
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 프로 갤러리 이미지 삭제
	 * 
	 * @param params
	 * @return map
	 */
	@RequestMapping(value = "/deleteGalleryImg")
	@ResponseBody
	public Map<String, Object> deleteGalleryImg(@RequestParam Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			proService.deleteGalleryImg(params);
			map.put("result", true);
		} catch (Exception e) {
			map.put("result", false);
			map.put("message", "파일 삭제 중 오류가 발생했습니다.");
		}
		return map;
	}

	/**
	 * 프로 갤러리 영상 삭제
	 * 
	 * @param params
	 * @return map
	 */
	@RequestMapping(value = "/deleteGalleryVideo")
	@ResponseBody
	public Map<String, Object> deleteGalleryVideo(@RequestParam Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			proService.deleteGalleryVideo(params);
			map.put("result", true);
		} catch (Exception e) {
			map.put("result", false);
			map.put("message", "파일 삭제 중 오류가 발생했습니다.");
		}
		return map;
	}

}
