// ==UserScript==
// @name         ViewGrip Auto Campaign Activator
// @namespace    https://www.viewgrip.net
// @version      1.0
// @description  Enables campaign if needed and starts worker
// @match        https://www.viewgrip.net/worker/start
// @match        https://www.viewgrip.net/campaign/edit/1299602
// @match        https://www.youtube.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

const currentUrl = window.location.href;

if (currentUrl.includes("/worker/start")) {
    // Step 1 stays unchanged
    const checkMessage = setInterval(() => {
        const messageDiv = document.getElementById("message");
        if (messageDiv && messageDiv.textContent.includes("To run the worker, you must have an active campaign")) {
            console.log("Campaign not active. Redirecting to enable it...");
            clearInterval(checkMessage);
            window.location.href = "https://www.viewgrip.net/campaign/edit/1299602";
        }
    }, 1000);

}
if (currentUrl.includes("youtube.com")) {
    const checkMessage = setInterval(() => {
        const textMessage = document.getElementById("TextMessage");
        if (textMessage && textMessage.textContent.includes("To run the worker, you must have an active campaign")) {
            console.log("Detected campaign message on YouTube. Redirecting...");
            clearInterval(checkMessage);
            window.location.href = "https://www.viewgrip.net/campaign/edit/1299602";
        }
    }, 2000);
}
if (currentUrl.includes("/campaign/edit/1299602")) {
    const waitForElements = setInterval(() => {
        const enableRadio = document.querySelector('input[type="radio"][value="enable"]');
        const saveBtn = document.querySelector('button[type="submit"], input[type="submit"], button.save');

        if (enableRadio && saveBtn) {
            clearInterval(waitForElements);

            // Delay selecting the radio button
            setTimeout(() => {
                if (!enableRadio.checked) {
                    enableRadio.checked = true;
                    console.log("Enable radio selected.");
                }

                // Delay clicking save after radio is selected
                setTimeout(() => {
                    console.log("Clicking Save button...");
                    saveBtn.click();

                    // Redirect after save
                    setTimeout(() => {
                        window.location.href = "https://www.viewgrip.net/worker/start";
                    }, 3000);
                }, 1000); // 1s delay before clicking Save
            }, 1000); // 1s delay before selecting radio
        }
    }, 500);

    setTimeout(() => clearInterval(waitForElements), 10000);
}

})();
