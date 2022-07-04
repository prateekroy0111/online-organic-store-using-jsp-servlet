/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).on("click", "#edit-product", function () {
    var productId = $(this).data('product-id');
    $.ajax({
        url: "ProductOperationServlet",
        method: "POST",
        data: {pId: productId, operation: "getProductDetails"},
        dataType: "json",
        success: function (responseJson) {
//                        console.log(responseJson);
            $('#editProductForm input[name="productID"]').val(responseJson.productID);
            $('#editProductForm input[name="ProdTitle"]').val(responseJson.ProdTitle);
            $('#editProductForm textarea[name="ProdDescp"]').text(responseJson.ProdDescp);
//                        $('#editProductForm input[name="ProdImg"]').val(responseJson.ProdImg);
            $('#editProductForm input[name="ProdPrice"]').val(responseJson.ProdPrice);
            $('#editProductForm input[name="ProdDiscount"]').val(responseJson.ProdDiscount);
            $('#editProductForm input[name="ProdQuantity"]').val(responseJson.ProdQuantity);

            var $select = $("#editProductForm #catid");
            $("<option>").val(responseJson.catId).text(responseJson.catName).attr('selected', 'selected').appendTo($select);
        },
        error: function () {
            alert("error");
        }

    });
});

$(document).on("click", "#edit-category", function () {
    var categoryId = $(this).data('category-id');
//    console.log("categoryId = "+categoryId);
    $.ajax({
        url: "ProductOperationServlet",
        method: "POST",
        data: {catId: categoryId, operation: "getCategoryDetails"},
        dataType: "json",
        success: function (responseJson) {
//            console.log(responseJson);
            $('#editCategoryForm input[name="categoryID"]').val(responseJson.categoryID);
            $('#editCategoryForm input[name="CatTitle"]').val(responseJson.CatTitle);
            $('#editCategoryForm textarea[name="CatDescp"]').text(responseJson.CatDescp);
        },
        error: function () {
            alert("error");
        }
    });
});

$(document).on("click", "#edit-user", function () {
    var userId = $(this).data('user-id');
    console.log("userId = "+userId);
    $.ajax({
        url: "ProductOperationServlet",
        method: "POST",
        data: {uId: userId, operation: "getUserDetails"},
        dataType: "json",
        success: function (responseJson) {
//            console.log(responseJson);
            $('#editUserForm input[name="userID"]').val(responseJson.userID);
            $('#editUserForm input[name="user_name"]').val(responseJson.user_name);
            $('#editUserForm input[name="user_email"]').val(responseJson.user_email);
            $('#editUserForm input[name="user_phone"]').val(responseJson.user_phone);
            $('#editUserForm textarea[name="user_add"]').text(responseJson.user_add);
        },
        error: function () {
            alert("error");
        }
    });
});