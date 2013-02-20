function report_exceptions(        key, sortpipe)
{
  sortpipe= Verbose ? "sort -f -t: -u -k1,1 -k2n,2 -k3" : "sort -f -u -k1"
  for (key in Exception)
  print Exception[key] | sortpipe
  close(sortpipe)
}
