$config = @{
  target = "misc"
}

foreach ($obj in (get-childitem -Path $config.target))
{
  select-string -path $obj.fullname -pattern "^-.*"
}

