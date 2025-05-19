use regex::Regex;
use std::ffi::CStr;
use std::os::raw::c_char;

#[no_mangle]
pub unsafe extern "C" fn for_each_match(
    pattern: *const c_char,
    text: *const c_char,
    callback: Option<extern "C" fn(start: usize, length: usize)>
) {
    if pattern.is_null() || text.is_null() || callback.is_none() {
        return;
    }

    let pattern_str = match CStr::from_ptr(pattern).to_str() {
        Ok(s) => s,
        Err(_) => return,
    };

    let text_str = match CStr::from_ptr(text).to_str() {
        Ok(s) => s,
        Err(_) => return,
    };

    let re = match Regex::new(pattern_str) {
        Ok(r) => r,
        Err(_) => return,
    };

    let callbackfu = callback.unwrap();

    for mat in re.find_iter(text_str) {
        callbackfu(mat.start(), mat.end());
    }
}