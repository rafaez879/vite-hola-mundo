provider "aws" {
  region = "us-east-1"
}

resource "aws_amplify_app" "hola_mundo" {
  name       = "vite-hola-mundo-alan"
  repository = "https://github.com/rafaez879/vite-hola-mundo"
  access_token = "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"

  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm ci
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: dist
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  custom_rule {
    source = "/<*>"
    status = "404-200"
    target = "/index.html"
  }
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.hola_mundo.id
  branch_name = "main"
}