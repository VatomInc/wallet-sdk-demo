package com.example.vatomwandroid

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.vatomwallet.VatomWallet

class MainActivity : AppCompatActivity() {
    var vatomWallet: VatomWallet? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        supportActionBar?.hide()

        var accessToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Imw0Mjd4WnJxNjJlR0xhS0hhc0d0bkkyZ1JZVjF3c0VUUm0weDlDcEZiOWsifQ.eyJ1cm46dmF0b21pbmM6Z3Vlc3QiOmZhbHNlLCJ1cm46dmF0b21pbmM6cmVnaW9uIjoidXMtZWFzdC0xLmF3cyIsImp0aSI6ImN0WkZqblFVazZQLW9Bal9MeEF0UyIsInN1YiI6IjFsbnlsOGUiLCJpYXQiOjE2NzkwMDQwMzMsImV4cCI6MTY3OTAwNzYzMywic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSBvZmZsaW5lX2FjY2VzcyIsImlzcyI6Imh0dHBzOi8vaWQudmF0b20uY29tIiwiYXVkIjoiM0g1cXB5aVF1OSJ9.GhS6bwP361rjfMUry0kvNz182gPGC0SSeUjZF9mNxcyofaVaifjsER4CbpNENPQvXa5DpUM9VDmkejZVotZDWmcYwkHYL_hm8LQQ1n_Qjuw4ehXKXlpLQUeI3YtPkLmcYDr-2e88BYdItUiz-fll4uQ44t8LGl_8BVtK-3M4-Yqo8bFWdbYerFkyKVNtWIp0kFgZHj3O5Ddm6Me8QV05ejXIA2vcMTWyjyFaK_Q6XZY1m4PJJ-fYGfxlUoNmZHpLMUnyrUls9aIstzF7x6TJna-tKuIbOKv1z11G5gzIZth55k_P7bJYhiYpwcWobDc8Lv1W5Ki5t1CFha9tYSN5Jw"

        this.vatomWallet = VatomWallet(this, accessToken, "lays")
        setContentView(this.vatomWallet)
        //vatomWallet.load()
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        this.vatomWallet!!.onPermissionsChanged(requestCode,permissions,grantResults)
    }
}

