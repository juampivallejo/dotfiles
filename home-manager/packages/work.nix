{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Beanstalk CLI
    awsebcli
    ssm-session-manager-plugin # For ECS ssh

    # Work
    cloudflare-warp
    aws-azure-login
  ];
}
