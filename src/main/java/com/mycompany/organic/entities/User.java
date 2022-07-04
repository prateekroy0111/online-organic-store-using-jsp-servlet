
package com.mycompany.organic.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity

public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(length = 10, name="user_id")
    private int userId;
    @Column(length = 100, name="user_name")
    private String userName;
    @Column(length = 100, name="user_email")
    private String userMail;
    @Column(length = 100, name="user_pass")
    private String userPass;
    @Column(length = 12, name="user_phone")
    private String userPhone;
    @Column(length = 1000, name="user_address")
    private String userAddress;

    @Column(name="user_type")
    private String userType;
    public User(int userId, String userName, String userMail, String userPass, String userPhone, String userAddress,String userType) {
        this.userId = userId;
        this.userName = userName;
        this.userMail = userMail;
        this.userPass = userPass;
        this.userPhone = userPhone;
        this.userAddress = userAddress;
        this.userType = userType;
    }

    public User(String userName, String userMail, String userPass, String userPhone, String userAddress, String userType) {
        this.userName = userName;
        this.userMail = userMail;
        this.userPass = userPass;
        this.userPhone = userPhone;
        this.userAddress = userAddress;
        this.userType = userType;
        
    }

    public User() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserMail() {
        return userMail;
    }

    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }
    
    
    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", userName=" + userName + ", userMail=" + userMail + ", userPass=" + userPass + ", userPhone=" + userPhone + ", userAddress=" + userAddress + '}';
    }
    
    
}
