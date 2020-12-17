package com.study.springboot.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrdersDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.repository.ImgRepository;
import com.study.springboot.repository.MemberRepository;
import com.study.springboot.repository.OrdersRepository;
import com.study.springboot.repository.ProjectRepository;

@Service
public class OrderService {

	@Autowired
	private OrdersRepository orderRepository;

	@Autowired
	private ProjectRepository projectRepository;

	@Autowired
	private MemberRepository memberRepository;

	@Autowired
	private ImgRepository imgRepository;

	public int sum;

	public OrdersDto setOrder(OrdersDto orderDto) {
		orderDto.setOrderDate(LocalDateTime.now());
		orderRepository.save(orderDto);
		return orderDto;
	}

	public OrdersDto getByOrderNo(Long orderNo) {
		return orderRepository.findByOrderNo(orderNo);
	}

	public Long getProNo(Long orderNo) {
		return orderRepository.findByOrderNo(orderNo).getProNo();
	}

	public Page<OrdersDto> findAll(Long memNo, Pageable pageable, String startDate, String endDate) {
		if (pageable.getSort().toString() == "UNSORTED") { // 정렬 값이 없다면 기본키 내림차순 정렬
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("orderNo").descending());
		}

		LocalDate start;
		LocalDate end;

		if (startDate == null || startDate.equals("") || endDate == null || endDate.equals("")) {
			start = LocalDate.parse("2000-01-01", DateTimeFormatter.ISO_DATE);
			end = LocalDate.now();
		} else {
			start = LocalDate.parse(startDate, DateTimeFormatter.ISO_DATE);
			end = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE);
		}

		LocalDateTime startDatetime = LocalDateTime.of(start, LocalTime.of(0, 0, 0)); // 2020-04-06 00:00:00
		LocalDateTime endDatetime = LocalDateTime.of(end, LocalTime.of(23, 59, 59)); // 2020-04-06 23:59:59

		Page<OrdersDto> orderArr = orderRepository.findAllByMemNoAndOrderDateBetween(memNo, startDatetime, endDatetime, pageable); // 연관 데이터(detail)조회를 위해 객체로
																																	// 담음
		orderArr.forEach(e -> { // 해당 회원의 전체 주문내역을 불러옴

			Optional<ProjectDto> projectOpt = projectRepository.findById(memNo); // 주문 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {

				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});

				Optional<MemberDto> memberOpt = memberRepository.findById(project.getMemNo()); // 프로젝트와 일치하는 회원 정보를 불러옴
				memberOpt.ifPresent(member -> {
					e.setProjectMemberName(member.getMemName()); // orderArr 리스트에 담기 위한 회원명 set
				});

				e.setProjectDto(project); // orderArr 리스트에 담기 위한 프로젝트 객체 set

			});

		});

		return orderArr;
	}

	public Page<OrdersDto> findAllByProType(Long memNo, String proType, Pageable pageable, String startDate, String endDate) {
		if (pageable.getSort().toString() == "UNSORTED") { // 정렬 값이 없다면 기본키 내림차순 정렬
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("order_no").descending()); // order_no -> nativeQuery=true
		}

		LocalDate start;
		LocalDate end;

		if (startDate == null || startDate.equals("") || endDate == null || endDate.equals("")) {
			start = LocalDate.parse("2000-01-01", DateTimeFormatter.ISO_DATE);
			end = LocalDate.now();
		} else {
			start = LocalDate.parse(startDate, DateTimeFormatter.ISO_DATE);
			end = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE);
		}

		LocalDateTime startDatetime = LocalDateTime.of(start, LocalTime.of(0, 0, 0)); // 2020-04-06 00:00:00
		LocalDateTime endDatetime = LocalDateTime.of(end, LocalTime.of(23, 59, 59)); // 2020-04-06 23:59:59

		Page<OrdersDto> orderArr = orderRepository.findAllByMemNoAndProType(memNo, proType, startDatetime, endDatetime, pageable); // 연관 데이터(detail)조회를 위해 객체로
																																	// 담음
		orderArr.forEach(e -> { // 해당 회원의 전체 주문내역을 불러옴

			Optional<ProjectDto> projectOpt = projectRepository.findById(memNo); // 주문 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {

				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});

				Optional<MemberDto> memberOpt = memberRepository.findById(project.getMemNo()); // 프로젝트와 일치하는 회원 정보를 불러옴
				memberOpt.ifPresent(member -> {
					e.setProjectMemberName(member.getMemName()); // orderArr 리스트에 담기 위한 회원명 set
				});

				e.setProjectDto(project); // orderArr 리스트에 담기 위한 프로젝트 객체 set

			});

		});

		return orderArr;
	}

	public int countByProNo(Long proNo) {
		return orderRepository.countByProNo(proNo);
	}

	public int getTotalPriceByProNo(Long proNo) {
		orderRepository.findAllByProNo(proNo).forEach(orderDto -> {
			sum += orderDto.getTotalPrice();
		});
		return sum;
	}

	public int findAllByProTypeSum(Long memNo, String proType, String startDate, String endDate) {
		LocalDate start;
		LocalDate end;

		if (startDate == null || startDate.equals("") || endDate == null || endDate.equals("")) {
			start = LocalDate.parse("2000-01-01", DateTimeFormatter.ISO_DATE);
			end = LocalDate.now();
		} else {
			start = LocalDate.parse(startDate, DateTimeFormatter.ISO_DATE);
			end = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE);
		}

		LocalDateTime startDatetime = LocalDateTime.of(start, LocalTime.of(0, 0, 0)); // 2020-04-06 00:00:00
		LocalDateTime endDatetime = LocalDateTime.of(end, LocalTime.of(23, 59, 59)); // 2020-04-06 23:59:59

		Long count = orderRepository.countByProType(memNo, proType, startDatetime, endDatetime);

		int sum = 0;

		if (count > 0) {
			sum = orderRepository.findAllByProTypeSum(memNo, proType, startDatetime, endDatetime);
		}

		return sum;
	}

	public int findAllSum(Long memNo, String startDate, String endDate) {
		LocalDate start;
		LocalDate end;

		if (startDate == null || startDate.equals("") || endDate == null || endDate.equals("")) {
			start = LocalDate.parse("2000-01-01", DateTimeFormatter.ISO_DATE);
			end = LocalDate.now();
		} else {
			start = LocalDate.parse(startDate, DateTimeFormatter.ISO_DATE);
			end = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE);
		}

		LocalDateTime startDatetime = LocalDateTime.of(start, LocalTime.of(0, 0, 0)); // 2020-04-06 00:00:00
		LocalDateTime endDatetime = LocalDateTime.of(end, LocalTime.of(23, 59, 59)); // 2020-04-06 23:59:59

		Long count = orderRepository.countByMemNoAndProTypeAndOrderDateBetween(memNo, startDatetime, endDatetime);

		int sum = 0;

		if (count > 0) {
			sum = orderRepository.findAllSum(memNo, startDatetime, endDatetime);
		}

		return sum;
	}

	// public void sumProNow(ProjectDto projectDto) {
	// Long sumTotalPrice = orderRepository.sumTotalPrice(projectDto.getProNo());
	// if (sumTotalPrice == null) {
	// sumTotalPrice = 0L;
	// }
	// projectDto.setProNo(projectDto.getProNo());
	// projectDto.setProNow(sumTotalPrice.intValue());
	// projectRepository.save(projectDto);
	// }
}
