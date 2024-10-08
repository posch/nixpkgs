{ buildGoModule
, clickhouse-backup
, fetchFromGitHub
, lib
, testers
}:

buildGoModule rec {
  pname = "clickhouse-backup";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "Altinity";
    repo = "clickhouse-backup";
    rev = "v${version}";
    hash = "sha256-FlF/XOZS3oaxW+LkWv8K47PVWR1vffkp9YnEH+eKFyA=";
  };

  vendorHash = "sha256-IEqxC4EzkEZnZru6U9O7U9kf375YKqBeyeJPqzaWbuM=";

  ldflags = [
    "-X main.version=${version}"
  ];

  postConfigure = ''
    export CGO_ENABLED=0
  '';

  passthru.tests.version = testers.testVersion {
    package = clickhouse-backup;
  };

  meta = with lib; {
    description = "Tool for easy ClickHouse backup and restore using object storage for backup files";
    mainProgram = "clickhouse-backup";
    homepage = "https://github.com/Altinity/clickhouse-backup";
    license = licenses.mit;
    maintainers = with maintainers; [ devusb ];
  };
}
