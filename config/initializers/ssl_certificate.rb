if Rails.env.production? && ENV["SSL_CERTIFICATE"]
  cert_path = Rails.root.join("tmp", "ssl_cert.crt").to_s
  File.open(cert_path, "w") { |file| file.write(ENV["SSL_CERTIFICATE"]) }
  ENV["SSL_CERTIFICATE_PATH"] = cert_path
  Rails.logger.info "証明書を #{cert_path} に書き込みました"
else
  Rails.logger.info Rails.env.production? ?
    "Rails.envがproductionではありません" :
    "SSL_CERTIFICATE環境変数が存在ません"
end
