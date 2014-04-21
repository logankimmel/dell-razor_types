rz_policy { 'centos65':
  ensure        => present,
  enabled       => true,
  repo          => 'centos65',
  installer     => 'centos',
  broker        => 'noop',
  hostname      => 'FV7QQV1.localdomain',
  root_password => 'password',
  max_count     => 2,
  rule_number   => 10,
  tags          => [
    {
      "name" => "Tag_10",
      "rule" =>
      [
        "=",
        [
          "fact",
          "serialnumber"
        ],
        "FV7QQV1"
      ]
    }
  ],
}

