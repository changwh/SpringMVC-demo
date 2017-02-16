package com.cwh.repository;

import com.cwh.model.InfoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by changwh1 on 2017/2/16.
 */
@Repository
public interface InfoRepository extends JpaRepository<InfoEntity,Integer>{

}
