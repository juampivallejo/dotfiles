{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Beanstalk CLI
    awsebcli
    ssm-session-manager-plugin # For ECS ssh

    # Work
    aws-azure-login
  ];
}
