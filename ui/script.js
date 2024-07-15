document.addEventListener("DOMContentLoaded", function() {
    const codeInputs = document.querySelectorAll("input[type='text'][id^='code-']");
    codeInputs.forEach((input, index) => {
      input.addEventListener("input", function() {
        const inputValue = this.value;
        if (inputValue !== "" && index < codeInputs.length - 1) {
          codeInputs[index + 1].focus();
        }
      });
    });
  });
  
  $(function () {
    let countdownInterval;
  
    function display(bool) {
      $("#container").toggle(bool);
    }
  
    display(false);
  
    function startCountdown() {
      const countdownElement = document.getElementById('countdownValue');
      let countdownValue = 120;
  
      countdownInterval = setInterval(() => {
        countdownValue--;
        countdownElement.textContent = countdownValue;
  
        if (countdownValue <= 0) {
          clearInterval(countdownInterval);
          $.post("https://benox-afk/kick", JSON.stringify({}));
        }
      }, 1000);
    }
  
    function resetCountdown() {
      clearInterval(countdownInterval);
      const countdownElement = document.getElementById('countdownValue');
      countdownElement.textContent = 120;
    }
    var kodas
  
    window.addEventListener('message', function(event) {
      var item = event.data;
      if (item.type === "ui") {
        if (item.status == true) {
          display(true);
          const code = document.getElementById('verification-code');
          code.textContent = item.pin;
          kodas = item.pin
          resetCountdown();
          startCountdown();
        } else {
          display(false);
          resetCountdown();
        }
      }
    });
    $("#submit").click(function () {
      
      var typedCode = getCodeValue();
    
      if (typedCode === kodas) {
        $.post("https://benox-afk/button", JSON.stringify({
          text: typedCode
        }));
      }
      resetInputFields()
    });
  });



  function getCodeValue() {
    var codeInput1 = document.getElementById("code-1");
    var codeInput2 = document.getElementById("code-2");
    var codeInput3 = document.getElementById("code-3");
    var codeInput4 = document.getElementById("code-4");
  
    var codeValue1 = codeInput1.value;
    var codeValue2 = codeInput2.value;
    var codeValue3 = codeInput3.value;
    var codeValue4 = codeInput4.value;
  
    var code = codeValue1 + codeValue2 + codeValue3 + codeValue4;
    return parseInt(code);
  }

  function resetInputFields() {
    var codeInput1 = document.getElementById("code-1");
    var codeInput2 = document.getElementById("code-2");
    var codeInput3 = document.getElementById("code-3");
    var codeInput4 = document.getElementById("code-4");
  
    // Clear the input fields
    codeInput1.value = "";
    codeInput2.value = "";
    codeInput3.value = "";
    codeInput4.value = "";
  }