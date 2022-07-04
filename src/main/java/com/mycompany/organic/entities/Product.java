
package com.mycompany.organic.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int pId;
    private String pName;
    @Column(length=3000)
    private String pDescp;
    private String pPhoto;
    private float pPrice;
    private float pDiscount;
    private float pQuantity;
    @ManyToOne
    private Category category;

    public Product() {
    }

    public Product(int pId, String pName, String pDescp, String pPhoto, float pPrice, float pDiscount, float pQuantity, Category category) {
        this.pId = pId;
        this.pName = pName;
        this.pDescp = pDescp;
        this.pPhoto = pPhoto;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQuantity = pQuantity;
        this.category =category;
    }

    public Product(String pName, String pDescp, String pPhoto, float pPrice, float pDiscount, float pQuantity,Category category) {
        this.pName = pName;
        this.pDescp = pDescp;
        this.pPhoto = pPhoto;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQuantity = pQuantity;
        this.category =category;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getpDescp() {
        return pDescp;
    }

    public void setpDescp(String pDescp) {
        this.pDescp = pDescp;
    }

    public String getpPhoto() {
        return pPhoto;
    }

    public void setpPhoto(String pPhoto) {
        this.pPhoto = pPhoto;
    }

    public float getpPrice() {
        return pPrice;
    }

    public void setpPrice(float pPrice) {
        this.pPrice = pPrice;
    }

    public float getpDiscount() {
        return pDiscount;
    }

    public void setpDiscount(float pDiscount) {
        this.pDiscount = pDiscount;
    }

    public float getpQuantity() {
        return pQuantity;
    }

    public void setpQuantity(float pQuantity) {
        this.pQuantity = pQuantity;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
    
    

    @Override
    public String toString() {
        return "Product{" + "pId=" + pId + ", pName=" + pName + ", pDescp=" + pDescp + ", pPhoto=" + pPhoto + ", pPrice=" + pPrice + ", pDiscount=" + pDiscount + ", pQuantity=" + pQuantity + '}';
    }
    
    //calculate price after discount
    
    public int getPriceAfterDiscount()
    {
        int d = (int) ((this.getpDiscount()/100.0)*this.getpPrice());
        return (int)this.getpPrice()- d;
    }
    
    
    
}
