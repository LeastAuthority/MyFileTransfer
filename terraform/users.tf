/*
 * Allow credentials self-management.
 */

// Bryan White <bryan@leastauthority.com>
resource "aws_iam_user" "bryan_white" {
  name = "bryan.white"
}

resource "aws_iam_user_login_profile" "bryan_white" {
  user = aws_iam_user.bryan_white.name
  pgp_key = "mQENBFP6FQEBCADVEjNNt2Sk3fvI51M3g5Lq/wsF5TDKsWDnbqIBJlPnpI3Nt7FosdC0bfcxzPneb6NpyV1vZj2xvO+cwJn/sXtZA9H+YpD1wd37TxWeLfQvHUCErafN23zFeelnWrbaFLzgAv6tDgoIshJ5mBb/SDxam8vZ34T4FwN9wWkKe7NtOWK2VmmZWJRbmi+8bVyjRr4tcl5b4/Yx285GpTOvYt0KdPQoHeD7756UxGPtl7IfcZbbVB/g79FS+d2vldEGql3bhthRpBv90Jrr3IsLSXBSp1lPyOGmFEmMLY34eenDKkGXpCKnyV2NA+jj97UOf49lXJAk3TAmbqhyLThIgMh9ABEBAAG0KUJyeWFuIEMgV2hpdGUgPGJyeWFuY2hyaXN3aGl0ZUBnbWFpbC5jb20+iQFUBBMBCgA+AhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAFiEEFTHxe7DY+b4CVZtFhc+ybjWHL5kFAmAulcsFCQ/258oACgkQhc+ybjWHL5lASwf7BU78djn550HTFahwbNhdMLQ078CUmEq2fT7BYsk/DUQ6rFfEKljazh/ltus18rdZ4dklTRypXZICCQLPPR9T1zQizXHENj0Nf9Osqs3ehqmuIp+2INIxV9/Fa5uVbl56tsPtQyGyjx4hGdkznTyhh2EjG9ITs+Ee1rE2S482hlQ80Zl03VlUZ5A09y+BYwo4JPBf+82eKBvlQOJ1a8gbEJ8AB47s7bTLiZkimp4TN9vTSdmaSuDKG1YYr1oJprSKf+m9NCK39OnrHTTw3mWQodVIHWZMb5+YVdmCyg3ol1UtyvQ8Mt8ugxQo+Ww6Nb36ZBzOfznoFIPXCFMzYzxk6bkBDQRT+hUBAQgAzq91M3ONROsS/4++QGQEWijvGGuwHpw7/4ZvTPjsIELrlczb6nenqDQOWcIMS4BN/Ika6lSJvFBCmYs6tDfV4ufrepjlOP9714PfAJf/guuf2+Fg5tMh663k6cRF2XCAy714bbfKTxBGReVYDAzARywMLXaNiEATWhJOpyVYX20dcXoAsiOq+YphUbgmT3Yxg4qGHlGSIknuYcMTgI76yAtAe1rzGZVeSipoi7OZNldTzQxAeEAT0Jlret8g9SO/PgQQOTEt9Ch0Q2sAEAqAfB5VMrAOkwZa/1tKUvloiZEPBiPA5lI28+0styDCXAqIIBdOVlp13wNJK1+m/n0YLwARAQABiQE8BBgBCgAmAhsMFiEEFTHxe7DY+b4CVZtFhc+ybjWHL5kFAmAulecFCQ/25+YACgkQhc+ybjWHL5mGqwf/dMBv5KKL2tlajin48KYCJBcdX9u/SqPwQEkQKWBknlAey2a+Fi0dZm44WATknaDNMECbPIJGS5IE4OISn8vdKQg0r1MgfJJljTHhS+rpA7dlHG/PAojYVSeupPXr7QdARE2hVo3AKDq5S7VE8RuE46skHYFwUtjX5AC4jFkTIPl7s51Kt3DVVRytHJDppTlYXWRAI5r2yCd/LXvWfMIXPaAhDvED0vrz5MN7k9ReT0dnu0hPX6Uyzi32zEduQl6bxCsLS/JkWs38cRcsdrmA4dDua/jk9MyL/bH61iylf2neD8F1hSUfRx1QxnDFwSVS3gbdCqRAHxIheIYLAqbmxA=="
  password_reset_required = false
}

output "password_bryan_white" {
  value = aws_iam_user_login_profile.bryan_white.encrypted_password
}

// Ram Muthukrishnan <ram@leastauthority.com>
resource "aws_iam_user" "ram_muthukrishnan" {
  name = "ram"
}

resource "aws_iam_user_login_profile" "ram_muthukrishnan" {
  user = aws_iam_user.ram_muthukrishnan.name
  pgp_key = "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"
  password_reset_required = false
}

output "password_ram_muthukrishnan" {
  value = aws_iam_user_login_profile.ram_muthukrishnan.encrypted_password
}

resource "aws_iam_group" "all_users" {
  name = "AllUsers"
}

resource "aws_iam_group_membership" "all-users-team" {
  name = "all-users-team-membership"
  group = aws_iam_group.all_users.name

  users = [
    aws_iam_user.bryan_white.name,
    aws_iam_user.ram_muthukrishnan.name,
  ]
}

resource "aws_iam_group_policy" "all-users-policy" {
  name = "all-users-policy"
  group = aws_iam_group.all_users.name

  policy = file("all_users_policy.json")
}
