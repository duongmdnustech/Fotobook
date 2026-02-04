import { I18n } from "i18n-js";
import translations from "./locales.json" with { type: "json" };// Đường dẫn file đã export

const i18n = new I18n(translations);

console.log(i18n.defaultLocale)
i18n.locale = "ei";
console.log(i18n.t("errors.messages.not_saved", {count: 7, resource: "User", locale: "pt"})); // Kết quả: "Hello"
console.log(i18n.numberToCurrency(1000000.9898, {precision: 3, delimiter: ",", locale: "vi"})); // Kết quả: "Xin chào"

console.log(i18n.strftime(new Date(), "%B %d", {locale: "en"})); // Kết quả: "Xin chào"
console.log(i18n.l("%B %d", new Date(), {locale: "vi"})); // Kết quả: "Xin chào"