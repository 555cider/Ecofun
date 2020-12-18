package com.study.springboot.service;

import java.time.LocalDateTime;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.ProjectCmtDto;
import com.study.springboot.repository.ProjectCmtRepository;

@Service
public class ProjectCmtService {

	@Autowired
	private ProjectCmtRepository CmtRepository;

	// 목록
	@Transactional
	public Page<ProjectCmtDto> findAllByProNo(Long proNo, Pageable pageable) {
		return CmtRepository.findByProNo(proNo, pageable);
	}

	// 입력
	@Transactional
	public ProjectCmtDto save(ProjectCmtDto proCmtDto) {
		proCmtDto.setProCmtDate(LocalDateTime.now());
		return CmtRepository.save(proCmtDto);
	}

	// 카운트
	@Transactional
	public long countCmt() {
		return CmtRepository.count();
	}
}