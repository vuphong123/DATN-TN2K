document.addEventListener('DOMContentLoaded', function () {
    const productModal = document.getElementById('product-modal');
    const customerModal = document.getElementById('customer-modal');
    const promoModal = document.getElementById('promo-modal');
    const salespersonModal = document.getElementById('salesperson-modal');

    const chooseProductBtn = document.getElementById('btn-choose-product');
    const chooseCustomerBtn = document.getElementById('btn-choose-customer');
    const chooseSalespersonBtn = document.getElementById('btn-choose-salesperson');

    const closeProductModalBtn = document.getElementById('btn-close-product-modal');
    const closeCustomerModalBtn = document.getElementById('btn-close-customer-modal');
    const closePromoModalBtn = document.getElementById('btn-close-promo-modal');
    const closeSalespersonModalBtn = document.getElementById('btn-close-salesperson-modal');

    const customerNameInput = document.getElementById('customer-name');
    const salespersonInput = document.getElementById('salesperson');
    const promoCodeInput = document.getElementById('promo-code');
    const invoiceTableBody = document.getElementById('invoice-table');
    const productListBody = document.getElementById('product-list');
    const invoiceCodeElement = document.getElementById('invoice-code');
    const totalPaymentElement = document.getElementById('total-payment');
    const createInvoiceBtn = document.getElementById('create-invoice');
    const productSearchInput = document.getElementById('product-search');
    const productTableBody = document.getElementById('product-table');
    const customerPaymentInput = document.getElementById('customer-payment');
    const returnMoneyElement = document.getElementById('return-money');
    const remainingMoneyElement = document.getElementById('remaining-money');

    let totalPayment = 0;
    let invoiceCounter = 1;
    let selectedInvoiceId = null;

    // Hiển thị modal chọn sản phẩm
    chooseProductBtn.addEventListener('click', () => toggleModal(productModal, true));

    // Đóng modal chọn sản phẩm
    closeProductModalBtn.addEventListener('click', () => toggleModal(productModal, false));

    // Hiển thị modal chọn khách hàng
    chooseCustomerBtn.addEventListener('click', () => toggleModal(customerModal, true));

    // Đóng modal chọn khách hàng
    closeCustomerModalBtn.addEventListener('click', () => toggleModal(customerModal, false));

    // Hiển thị modal chọn nhân viên
    chooseSalespersonBtn.addEventListener('click', () => toggleModal(salespersonModal, true));

    // Đóng modal chọn nhân viên
    closeSalespersonModalBtn.addEventListener('click', () => toggleModal(salespersonModal, false));

    // Hiển thị modal chọn khuyến mãi
    document.getElementById('btn-choose-promo').addEventListener('click', () => toggleModal(promoModal, true));

    // Đóng modal chọn khuyến mãi
    closePromoModalBtn.addEventListener('click', () => toggleModal(promoModal, false));

    // Thêm sản phẩm vào danh sách khi bấm nút "Thêm"
    productTableBody.addEventListener('click', function (e) {
        if (e.target.classList.contains('btn-add-product')) {
            addProductToInvoice(e.target);
            toggleModal(productModal, false);
        }
    });

    // Cập nhật tổng tiền khi thay đổi số lượng sản phẩm
    productListBody.addEventListener('input', function (e) {
        if (e.target.classList.contains('product-quantity')) {
            updateTotalPrice();
        }
    });

    // Xóa sản phẩm khỏi danh sách
    productListBody.addEventListener('click', function (e) {
        if (e.target.classList.contains('btn-delete-product')) {
            e.target.closest('tr').remove();
            updateTotalPrice();
        }
    });

    // Chọn khách hàng từ modal
    document.getElementById('customer-table').addEventListener('click', function (e) {
        if (e.target.classList.contains('btn-add-customer')) {
            customerNameInput.value = e.target.getAttribute('data-name');
            toggleModal(customerModal, false);
        }
    });

    // Chọn nhân viên từ modal
    document.getElementById('salesperson-table').addEventListener('click', function (e) {
        if (e.target.classList.contains('btn-add-salesperson')) {
            salespersonInput.value = e.target.getAttribute('data-name');
            toggleModal(salespersonModal, false);
        }
    });

    // Chọn khuyến mãi từ modal
    document.getElementById('promo-table').addEventListener('click', function (e) {
        if (e.target.classList.contains('btn-add-promo')) {
            promoCodeInput.value = e.target.getAttribute('data-code');
            toggleModal(promoModal, false);
        }
    });

    // Tạo hóa đơn chờ
    createInvoiceBtn.addEventListener('click', function () {
        createInvoice();
    });

    // Chọn và xóa hóa đơn chờ
    invoiceTableBody.addEventListener('click', function (e) {
        if (e.target.classList.contains('btn-choose-invoice')) {
            selectInvoice(e.target);
        } else if (e.target.classList.contains('btn-delete-invoice')) {
            e.target.closest('tr').remove();
            resetInvoice();
        }
    });

    // Tìm kiếm sản phẩm theo tên
    productSearchInput.addEventListener('input', function () {
        searchProductByName(productSearchInput.value);
    });

    // Cập nhật trả tiền khách hàng
    customerPaymentInput.addEventListener('input', function () {
        calculateCustomerMoney();
    });

    // ----- Helper Functions -----

    // Hiển thị/Ẩn modal
    function toggleModal(modalElement, show) {
        if (show) {
            modalElement.style.display = 'block';
        } else {
            modalElement.style.display = 'none';
        }
    }

    // Thêm sản phẩm vào danh sách hóa đơn
    function addProductToInvoice(button) {
        const productName = button.getAttribute('data-name');
        const png = button.getAttribute('data-picture');
        const productPrice = button.getAttribute('data-price');
        const rowCount = productListBody.getElementsByTagName('tr').length;
        const productSize = button.getAttribute('data-size');
        const productColor = button.getAttribute('data-color');
        const newRow = `
            <tr>
                <td>${rowCount + 1}</td>
                <td>${productName}</td>
                <td>${png}</td>
                <td>${productSize}</td>
                <td>${productColor}</td>
                <td>
                    <input type="number" value="1" min="1" class="product-quantity" data-price="${productPrice}">
                </td>
                <td><button class="btn-delete-product">Xóa</button></td>
            </tr>
        `;
        productListBody.insertAdjacentHTML('beforeend', newRow);
        updateTotalPrice();
    }

    // Tạo hóa đơn mới
    function createInvoice() {
        const customerName = "Chưa chọn khách hàng";
        const newRow = `
            <tr>
                <td>${invoiceCounter}</td>
                <td>HD${invoiceCounter}</td>
                <td>${new Date().toLocaleDateString()}</td>
                <td>${customerName}</td>
                <td><button class="btn-choose-invoice" data-invoice-id="${invoiceCounter}">Chọn</button></td>
                <td><button class="btn-delete-invoice">Xóa</button></td>
            </tr>
        `;
        invoiceTableBody.insertAdjacentHTML('beforeend', newRow);
        invoiceCounter++;
        resetInvoice();
    }

    // Chọn hóa đơn
    function selectInvoice(button) {
        selectedInvoiceId = button.getAttribute('data-invoice-id');
        invoiceCodeElement.textContent = `HD${selectedInvoiceId}`;
        chooseProductBtn.disabled = false;
        alert(`Bạn đã chọn hóa đơn HD${selectedInvoiceId}`);
    }

    // Cập nhật tổng tiền
    function updateTotalPrice() {
        totalPayment = 0;
        const quantities = document.querySelectorAll('.product-quantity');

        quantities.forEach(function (input) {
            const quantity = input.value;
            const price = input.getAttribute('data-price');
            totalPayment += quantity * price;
        });

        totalPaymentElement.textContent = totalPayment.toLocaleString() + 'đ';
        calculateCustomerMoney(); // Cập nhật số tiền khách hàng trả và số còn thiếu
    }

    // Tính tiền trả lại và còn thiếu
    function calculateCustomerMoney() {
        const customerPayment = parseInt(customerPaymentInput.value) || 0;
        const returnMoney = customerPayment - totalPayment;

        if (returnMoney >= 0) {
            returnMoneyElement.textContent = returnMoney.toLocaleString() + 'đ';
            remainingMoneyElement.textContent = '0đ';
        } else {
            returnMoneyElement.textContent = '0đ';
            remainingMoneyElement.textContent = (-returnMoney).toLocaleString() + 'đ';
        }
    }

    // Tìm kiếm sản phẩm theo tên
    function searchProductByName(query) {
        const rows = productTableBody.getElementsByTagName('tr');
        Array.from(rows).forEach(row => {
            const productName = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
            if (productName.includes(query.toLowerCase())) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // Đặt lại hóa đơn sau khi tạo
    function resetInvoice() {
        productListBody.innerHTML = ''; // Xóa sản phẩm
        promoCodeInput.value = ''; // Xóa mã khuyến mãi
        totalPayment = 0;
        updateTotalPrice(); // Cập nhật lại tổng tiền
        invoiceCodeElement.textContent = 'HDxxxx'; // Đặt lại mã hóa đơn
        chooseProductBtn.disabled = true;
    }
});
