/* global cart */

function add_to_cart(pid, pname, pprice)
{
    let cart = localStorage.getItem("cart");
    if (cart == null)
    {
        //no cart present
        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: pprice};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        //console.log("product is added for the first time");
        showToast("Item is added to cart !");


    } else
    {
        //cart is present already
        let pcart = JSON.parse(cart);
        let oldproduct = pcart.find((item) => item.productId == pid);
        if (oldproduct)
        {
            //only we have to increase the quantity
            oldproduct.productQuantity = oldproduct.productQuantity + 1;
            pcart.map((item) => {
                if (item.productId == oldproduct.productId)
                {
                    item.productQuantity = oldproduct.productQuantity;

                }

            });
            localStorage.setItem("cart", JSON.stringify(pcart));
            //console.log("Product quantity is increased");
            showToast(oldProduct.productName + "quantity is increased !");
        } else
        {
            //we have to add product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: pprice};
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            //console.log("product is added");
            showToast("Item is added to cart !");
        }


    }

    updateCart();


}

//update cart
function updateCart()
{
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart == null || cart.length == 0)
    {
        console.log("cart is Empty !");
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h3> cart is empty !</h3>");
        $(".checkout-btn").attr('disabled', true);

    } else
    {
        //there is something in cart to show
        console.log(cart);
        $(".cart-items").html(`(${cart.length} )`);
        let table = ` 
            <table class='table'>
            <thead class='thead-light'>
            <tr>
            <th>Item name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total price</th>
            <th>Action</th>
            
            </tr>
        
            </thead>

`;
        let totalPrice = 0;
        cart.map((item) => {
            table += `
                        <tr>
                        <td>${item.productName}</td>
                        <td>${item.productPrice}</td>
                        <td>${item.productQuantity}</td>
                        <td>${item.productQuantity * item.productPrice}</td>
                        <td><button onclick='deleteItemFromCart(${item.productId})' class="btn btn-sm btn-danger")">Remove</button></td>
            
                        </tr>
                      `;
            totalPrice += item.productPrice * item.productQuantity;
        });


        table = table + `
            <tr><td colspan='5' class='text-right font-weight-bold m-3 mt-2'>Total Price:${totalPrice}</td></tr>
</table>`;
        $(".cart-body").html(table);
        $(".checkout-btn").attr('disabled', false);
    }
}

function deleteItemFromCart(pid)
{
    let cart = JSON.parse(localStorage.getItem('cart'));

    let newcart = cart.filter((item) => item.productId != pid)

    localStorage.setItem('cart', JSON.stringify(newcart))

    updateCart();

    showToast("Item is removed from the cart !");

}

function emptyCart()
{
    localStorage.removeItem('cart');
    console.log(localStorage);
}


$(document).ready(function () {
    updateCart();
})

function showToast(content) {
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() =>
    {
        $("#toast").removeClass("display");
    }, 2000)
}

function goToCheckout()
{
    window.location = "checkout.jsp";
}