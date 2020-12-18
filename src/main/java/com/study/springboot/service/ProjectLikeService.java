package com.study.springboot.service;

import java.time.LocalDateTime;
import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.dto.ProjectLikeDto;
import com.study.springboot.repository.ImgRepository;
import com.study.springboot.repository.ProjectLikeRepository;
import com.study.springboot.repository.ProjectRepository;

@Service
public class ProjectLikeService {

	@Autowired
	private ProjectLikeRepository projectLikeRepository;

	@Autowired
	private ProjectRepository projectRepository;

	@Autowired
	private ImgRepository imgRepository;

	public ProjectLikeDto save(ProjectLikeDto likeDto, HttpServletRequest request) {
		likeDto.setLikeDate(LocalDateTime.now());
		likeDto.setMemNo((Long) request.getSession().getAttribute("memNo"));
		return projectLikeRepository.save(likeDto);
	}

	public Long countByMemNoAndProNo(Long proNo, HttpServletRequest request) {
		return projectLikeRepository.countByMemNoAndProNo((Long) request.getSession().getAttribute("memNo"), proNo);
	}

	public Long delete(ProjectLikeDto likeDto, HttpServletRequest request) {
		return projectLikeRepository.deleteByMemNoAndProNo((Long) request.getSession().getAttribute("memNo"), likeDto.getProNo());
	}

	public Page<ProjectLikeDto> findAll(HttpServletRequest request, Pageable pageable) {
		String proType = request.getParameter("proType");
		String proState = request.getParameter("proState");

		Page<ProjectLikeDto> likeArr = null;

		if (proType != null && !proType.equals("") && proState != null && !proState.equals("")) {
			likeArr = findAllByMemNoAndProTypeAndProState(request, pageable);
		} else if (proType != null && !proType.equals("")) {
			likeArr = findAllByMemNoAndProType(request, pageable);
		} else if (proState != null && !proState.equals("")) {
			likeArr = findAllByMemNoAndProState(request, pageable);
		} else {
			likeArr = findAllByMemNo(request, pageable);
		}
		return likeArr;
	}

	private Page<ProjectLikeDto> findAllByMemNo(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");

		if (pageable.getSort().toString() == "UNSORTED") { // 정렬 값이 없다면 기본키 내림차순 정렬
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("LikeNo").descending());
		}

		Page<ProjectLikeDto> likeArr = projectLikeRepository.findAllByMemNo(memNo, pageable);
		likeArr.forEach(e -> { // 해당 회원의 좋아한 프로젝트 내역을 불러옴
			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo()); // 좋아한 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {
				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});
				e.setProjectDto(project); // ProjectLikeDto 리스트에 담기 위한 프로젝트 객체 set
			});
		});
		return likeArr;
	}

	private Page<ProjectLikeDto> findAllByMemNoAndProType(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proType = request.getParameter("proType");

		Page<ProjectLikeDto> likeArr = projectLikeRepository.findAllByMemNoAndProType(memNo, proType, pageable);
		likeArr.forEach(e -> { // 해당 회원의 좋아한 프로젝트 내역을 불러옴
			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo()); // 좋아한 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {
				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});
				e.setProjectDto(project); // ProjectLikeDto 리스트에 담기 위한 프로젝트 객체 set
			});
		});
		return likeArr;
	}

	private Page<ProjectLikeDto> findAllByMemNoAndProState(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proState = request.getParameter("proState");

		Page<ProjectLikeDto> likeArr = projectLikeRepository.findAllByMemNoAndProState(memNo, proState, pageable);
		likeArr.forEach(e -> { // 해당 회원의 좋아한 프로젝트 내역을 불러옴
			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo()); // 좋아한 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {
				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});
				e.setProjectDto(project); // ProjectLikeDto 리스트에 담기 위한 프로젝트 객체 set
			});
		});
		return likeArr;
	}

	private Page<ProjectLikeDto> findAllByMemNoAndProTypeAndProState(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proType = request.getParameter("proType");
		String proState = request.getParameter("proState");

		Page<ProjectLikeDto> likeArr = projectLikeRepository.findAllByMemNoAndProTypeAndProState(memNo, proType, proState, pageable);
		likeArr.forEach(e -> { // 해당 회원의 좋아한 프로젝트 내역을 불러옴
			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo()); // 좋아한 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {
				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});
				e.setProjectDto(project); // ProjectLikeDto 리스트에 담기 위한 프로젝트 객체 set
			});
		});
		return likeArr;
	}

	public int countByMemNo(HttpServletRequest request) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		return projectLikeRepository.findAllByMemNo(memNo).size();
	}
}
