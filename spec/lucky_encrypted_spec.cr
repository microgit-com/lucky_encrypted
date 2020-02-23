require "./spec_helper"
ENV["ENCRYPTED_SECRET"] = "seoVGHoTUV+rELWE/tlH145unCmdq18/OOsjuKWTS30="
describe LuckyEncrypted::StringEncrypted do
  # TODO: Write tests

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
    LuckyEncrypted::StringEncrypted::Lucky.parse(encrypted_value).value.to_s.should eq("encrypted3")
  end
end
