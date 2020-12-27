package com.study.springboot.repository;

import java.time.LocalDateTime;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.OrdersDto;

@Repository
public interface OrdersRepository extends JpaRepository<OrdersDto, Long> {

	public OrdersDto findByOrderNo(Long orderNo);

	public List<OrdersDto> findAllByMemNo(Long memNo);
	
	public List<OrdersDto> findAllByProNo(Long proNo);
	
	public Page<OrdersDto> findAllByMemNoAndOrderDateBetween(Long memNo, LocalDateTime startDatetime, LocalDateTime endDatetime, Pageable pageable);

	@Query(value = "SELECT " + "o.* " + "FROM " + "orders o, project p " + "WHERE " + "o.mem_no = :memNo " + "AND " + "o.pro_no = p.pro_no " + "AND " + "p.pro_type = :proType " + "AND " + "o.order_date BETWEEN :startDatetime AND :endDatetime", countQuery = "SELECT " // 네이티브
		+ "COUNT(*) " + "FROM " + "orders o, project p " + "WHERE " + "o.mem_no = :memNo " + "AND " + "o.pro_no = p.pro_no " + "AND " + "p.pro_type = :proType " + "AND " + "o.order_date BETWEEN :startDatetime AND :endDatetime", nativeQuery = true)
	public Page<OrdersDto> findAllByMemNoAndProTypeAndOrderDateBetween(@Param("memNo") Long memNo, @Param("proType") String proType, @Param("startDatetime") LocalDateTime startDatetime, @Param("endDatetime") LocalDateTime endDatetime, Pageable pageable);

	public int countByProNo(Long proNo);

	public int countByMemNo(Long memNo);

	@Query(value = "SELECT " + "COUNT(*) " + "FROM " + "orders o, project p " + "WHERE " + "o.mem_no = :memNo " + "AND " + "o.pro_no = p.pro_no " + "AND " + "o.order_date BETWEEN :startDatetime AND :endDatetime", nativeQuery = true)
	public Long countByMemNoAndOrderDateBetween(@Param("memNo") Long memNo, @Param("startDatetime") LocalDateTime startDatetime, @Param("endDatetime") LocalDateTime endDatetime);

	@Query(value = "SELECT " + "COUNT(*) " + "FROM " + "orders o, project p " + "WHERE " + "o.mem_no = :memNo " + "AND " + "o.pro_no = p.pro_no " + "AND " + "p.pro_type = :proType " + "AND " + "o.order_date BETWEEN :startDatetime AND :endDatetime", nativeQuery = true)
	public Long countByMemNoAndProTypeAndOrderDateBetween(@Param("memNo") Long memNo, @Param("proType") String proType, @Param("startDatetime") LocalDateTime startDatetime, @Param("endDatetime") LocalDateTime endDatetime);

	@Query(value = "SELECT " + "SUM(o.total_price) " + "FROM " + "orders o " + "WHERE " + "o.pro_no = :proNo ", nativeQuery = true)
	public Long sumTotalPrice(@Param("proNo") Long proNo);

	@Query(value = "SELECT " + "SUM(o.total_price) " + "FROM " + "orders o, project p " + "WHERE " + "o.mem_no = :memNo " + "AND " + "o.pro_no = p.pro_no " + "AND " + "o.order_date BETWEEN :startDatetime AND :endDatetime", nativeQuery = true)
	public int sumTotalPriceByMemNoAndOrderDateBetween(@Param("memNo") Long memNo, @Param("startDatetime") LocalDateTime startDatetime, @Param("endDatetime") LocalDateTime endDatetime);

	@Query(value = "SELECT " + "SUM(o.total_price) " + "FROM " + "orders o, project p " + "WHERE " + "o.mem_no = :memNo " + "AND " + "o.pro_no = p.pro_no " + "AND " + "p.pro_type = :proType " + "AND " + "o.order_date BETWEEN :startDatetime AND :endDatetime", nativeQuery = true)
	public int sumTotalPriceByMemNoAndProTypeAndOrderDateBetween(@Param("memNo") Long memNo, @Param("proType") String proType, @Param("startDatetime") LocalDateTime startDatetime, @Param("endDatetime") LocalDateTime endDatetime);
}
