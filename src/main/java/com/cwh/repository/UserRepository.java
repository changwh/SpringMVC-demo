package com.cwh.repository;

import com.cwh.model.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by changwh1 on 2017/2/16.
 */
@Repository
public interface UserRepository extends JpaRepository<UserEntity,Integer>{
    //说明该方法是修改操作
    @Modifying
    //说明该方法是事务性操作
    @Transactional
    //定义查询
    @Query("update UserEntity us set us.name=:qName,us.sex=:qSex,us.age=:qAge where us.id=:qId")
    public void updateUser(@Param("qName")String name,@Param("qSex")String sex,@Param("qAge")int age,@Param("qId")int id);

    /**
     * 查询男/女性用户数量
     * @param sex
     * @return
     */
    @Query("select count(*) from UserEntity us where us.sex=:qSex")
    public long getSexNum(@Param("qSex")String sex);

    /**
     * 查询某个年龄段的男/女性用户数量
     * @param sex
     * @param ageMin
     * @param ageMax
     * @return
     */
    @Query("select count (*) from UserEntity us where us.sex=:qSex and us.age>=:qAgeMin and us.age<=:qAgeMax")
    public long getAgeNum(@Param("qSex")String sex,@Param("qAgeMin")int ageMin,@Param("qAgeMax")int ageMax);

    /**
     * 查询某个年龄段的用户数量
     * @param ageMin
     * @param ageMax
     * @return
     */
    @Query("select count (*) from UserEntity us where us.age>=:qAgeMin and us.age<=:qAgeMax")
    public long getALLAgeNum(@Param("qAgeMin")int ageMin,@Param("qAgeMax")int ageMax);
}
