package com.cwh.model;

import org.springframework.data.annotation.*;

import javax.persistence.*;
import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Collection;

/**
 * Created by changwh1 on 2017/2/16.
 */
@Entity
@Table(name = "user", schema = "test", catalog = "")
public class UserEntity {
    private int id;
    private String name;
    private String sex;
    private int age;
    private Collection<InfoEntity> infoById;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "name", nullable = false, length = 45)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "sex", nullable = false, length = 10)
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Basic
    @Column(name = "age", nullable = false)
    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserEntity that = (UserEntity) o;

        if (id != that.id) return false;
        if (age != that.age) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (sex != null ? !sex.equals(that.sex) : that.sex != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (sex != null ? sex.hashCode() : 0);
        result = 31 * result + age;
        return result;
    }

    //fetch=FetchType.EAGER,关闭懒加载，解决“代理不能被初始化，session已经关闭”的问题
    @OneToMany(mappedBy = "userByUserId",fetch=FetchType.EAGER)
    //将原来的“双向关系”修改为“单向关系”，使其无法反向获取数值，避免因为关闭了fastjson的循环引用检测而出现的StackOverflowError
    @Transient
    public Collection<InfoEntity> getInfoById() {
        return infoById;
    }

    public void setInfoById(Collection<InfoEntity> infoById) {
        this.infoById = infoById;
    }
}
