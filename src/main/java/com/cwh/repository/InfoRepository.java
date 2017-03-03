package com.cwh.repository;

import com.cwh.model.InfoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by changwh1 on 2017/2/16.
 */
@Repository
public interface InfoRepository extends JpaRepository<InfoEntity,Integer>{

    @Modifying
    @Transactional
    @Query("update  InfoEntity info set info.address=:qAddress,info.phone=:qPhone,info.email=:qEmail,info.mobile=:qMobile,info.userByUserId.id=:qUserId where info.id=:qId")
    public void updateInfo(@Param("qPhone") String phone,@Param("qAddress") String address,@Param("qEmail") String email,@Param("qMobile") String mobile,@Param("qUserId") int userId,@Param("qId") int id);
}
