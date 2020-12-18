package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.ProjectCmtDto;

@Repository
public interface ProjectCmtRepository extends JpaRepository<ProjectCmtDto, Long> {
	public Page<ProjectCmtDto> findByProNo(Long proNo, Pageable pageable);
}
