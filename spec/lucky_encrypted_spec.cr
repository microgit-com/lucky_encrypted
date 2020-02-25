require "./spec_helper"
describe LuckyEncrypted::StringEncrypted do
  before_each do
    LuckyEncrypted.configure do |c|
      c.secret = "seoVGHoTUV+rELWE/tlH145unCmdq18/OOsjuKWTS30="
    end
  end

  it "value is set" do
    encryptor = LuckyEncrypted::StringEncrypted.new("encrypted")
    encryptor.to_s.should eq("encrypted")
  end

  it "value is encrypted" do
    encryptor = LuckyEncrypted::StringEncrypted.new("encrypted")
    LuckyEncrypted::StringEncrypted::Lucky.to_db("encrypted2").should_not eq("encrypted2")
  end

  it "value is decrypted" do
    encryptor = LuckyEncrypted::StringEncrypted.new("encrypted")

    encrypted_value = LuckyEncrypted::StringEncrypted::Lucky.to_db("encrypted3")
    LuckyEncrypted::StringEncrypted::Lucky.from_db!(encrypted_value).value.to_s.should eq("encrypted3")
  end
end
