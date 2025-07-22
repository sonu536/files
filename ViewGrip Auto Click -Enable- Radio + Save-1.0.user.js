// ==UserScript==
// @name         ViewGrip Auto Click "Enable" Radio + Save
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Clicks the radio with value="enable" and then clicks Save every 3 minutes
// @match        https://www.viewgrip.net/campaign/edit/*
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    function clickRadioAndSave() {
        const radio = document.querySelector('input[type="radio"][name="status"][value="enable"]');
        const saveBtn = document.querySelector('button[type="submit"].btn.btn-primary');

        if (!radio) {
            console.warn("❌ Radio button with value='enable' not found.");
            return;
        }

        if (!radio.checked) {
            radio.checked = true;
            radio.dispatchEvent(new MouseEvent('click', { bubbles: true }));
            radio.dispatchEvent(new Event('change', { bubbles: true }));
            console.log("✅ Radio with value='enable' selected.");
        }

        if (saveBtn) {
            saveBtn.click();
            console.log("✅ Save button clicked.");
        } else {
            console.warn("❌ Save button not found.");
        }
    }

    // Wait for page load, then retry until both radio & button exist
    function waitUntilReady() {
        const interval = setInterval(() => {
            const radio = document.querySelector('input[type="radio"][name="status"][value="enable"]');
            const save = document.querySelector('button[type="submit"].btn.btn-primary');
            if (radio && save) {
                clearInterval(interval);
                clickRadioAndSave(); // Run once
                setInterval(clickRadioAndSave, 180000); // Then every 3 minutes
            }
        }, 1000);
    }

    window.addEventListener('load', waitUntilReady);
})();
