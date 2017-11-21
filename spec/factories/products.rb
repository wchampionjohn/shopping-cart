FactoryBot.define do

  factory :product, class: Product do
    title Faker::Lorem.word
    description Faker::Lorem.sentence
    price Faker::Number.between(1000, 9999)
    calculate Faker::Number.between(1, 99)
    status :all_new

    trait :iphone do
      title "iPhone 6S 64G灰/金/銀/粉 未拆封 保固一年 4G LTE 蘋果6S 送玻璃貼 手機套"
      description "CCAI154G0120T0 CCAI154G0120T0 iPhone ( 機)(GSM/DCS/WCDMA/LTE/WLAN/Bluetooth) Apple A1688 美商蘋果亞洲股份有限公司台灣分公司 蘋果 Apple iPhone 智慧型手機 全新手機現貨報價"
      price 13400
    end

    trait :ipad do
      title "Apple iPad 32G WiFi 金 (MPGT2TA/A)"
      description "．9.7 吋 Retina 顯示器．64 位元架構的 A9 晶片．M9 協同處理．800 萬像素攝錄鏡頭．長達10小時電池使用時間 "
      price 10900
    end
  end
end
