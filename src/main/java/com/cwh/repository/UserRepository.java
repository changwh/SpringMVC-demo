package com.cwh.repository;

import com.cwh.model.UserEntity;
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
}
