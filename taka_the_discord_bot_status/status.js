const TITLE_ID="title";
const STATUS_ID="status";
const STATUS_TEXT_ID = "status_text";
const OK_CLASS="ok";
const OFFLINE_CLASS="offline";
const UNKNOWN_CLASS="unknown"
const element = document.createElement("a");
element.id = "status_box";
const title = document.createElement("h2");
title.id = TITLE_ID;
element.appendChild(title);
// Status
const status = document.createElement("div");
status.id = STATUS_ID;
const status_text = document.createElement("p");
status_text.id = STATUS_TEXT_ID;
status.appendChild(status_text);
element.appendChild(status);


/**
 * 
 * @param {HTMLElement} container 
 * @param {string} name 
 * @param {string} url 
 * @param {string} description 
 */
export async function createStatus(container, name, url, description) {
    const result = (await Promise.allSettled([fetch(url)]))[0];
    console.log(name, url);
    if (result.status == "fulfilled") {
        if(result.value.ok) {
            return ok_status(container, name, url, description)
        }
        else {
            return rejected_status(container, name, url, description)
        }
    }
    else if(result.status == "rejected") {
        return rejected_status(container, name, url, description)
    }
    else {
        return unknown_status(container, name, url, description)
    }
    
}

/**
 * 
 * @param {HTMLElement} container 
 * @param {string} name 
 * @param {string} url 
 * @param {string} description 
 */
async function ok_status(container, name, url, description) {
    const copy = element.cloneNode(true);
    copy.classList.add(OK_CLASS);
    copy.href = url;
    copy.querySelector("#" + TITLE_ID).innerHTML = name;
    copy.querySelector("#" + STATUS_TEXT_ID).innerHTML = "OK";
    container.appendChild(copy);
}

/**
 * 
 * @param {HTMLElement} container 
 * @param {string} name 
 * @param {string} url 
 * @param {string} description 
 */
async function unknown_status(container, name, url, description) {
    const copy = element.cloneNode(true);
    copy.href = url;
    copy.querySelector("#" + TITLE_ID).innerHTML = name;
    copy.querySelector("#" + STATUS_TEXT_ID).innerHTML = "Unknown Status";
    copy.classList.add(UNKNOWN_CLASS);
    container.appendChild(copy);
}
/**
 * 
 * @param {HTMLElement} container 
 * @param {string} name 
 * @param {string} url 
 * @param {string} description 
 */
async function rejected_status(container, name, url, description) {
    const copy = element.cloneNode(true);
    console.log(name, url)
    copy.href = url;
    copy.querySelector("#" + TITLE_ID).innerHTML = name;
    copy.querySelector("#" + STATUS_TEXT_ID).innerHTML = "Offline";
    copy.classList.add(OFFLINE_CLASS);
    container.appendChild(copy);
}