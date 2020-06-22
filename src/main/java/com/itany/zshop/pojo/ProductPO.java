package com.itany.zshop.pojo;

import java.io.Serializable;

public class ProductPO implements Serializable {

    private Integer id;
    private String name;
    private Double price;
    private String info;
    private String image;
    private ProductTypePO productTypePO;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public ProductTypePO getProductTypePO() {
        return productTypePO;
    }

    public void setProductTypePO(ProductTypePO productTypePO) {
        this.productTypePO = productTypePO;
    }
}
