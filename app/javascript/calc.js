function calc() {
  const tax = 0.1;
  const price =  document.getElementById("item-price");
  const add_tax_price =  document.getElementById("add-tax-price");
  const profit =  document.getElementById("profit");

  price.addEventListener('keyup', () => {
    const calc_tax = Math.floor(price.value * tax);
    const calc_profit = Math.floor(price.value - calc_tax);

    add_tax_price.innerHTML = calc_tax.toLocaleString();
    profit.innerHTML = calc_profit.toLocaleString();
  });
};

window.addEventListener('load', calc);