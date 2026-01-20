package util

import (
	"os"
	"time"

	"github.com/joho/godotenv"
	// "github.com/spf13/viper"
)

// Config stores all configurations of the application
// The valuies are read by viper from a config file or environment variables
type Config struct {
	DBDriver             string        `mapstructure:"DB_DRIVER"`
	DBSource             string        `mapstructure:"DB_SOURCE"`
	ServerAddress        string        `mapstructure:"SERVER_ADDRESS"`
	TokenSymmetricKey    string        `mapstructure:"TOKEN_SYMMETRIC_KEY"`
	AccessTokenDuration  time.Duration `mapstructure:"ACCESS_TOKEN_DURATION"`
	RefreshTokenDuration time.Duration `mapstructure:"REFRESH_TOKEN_DURATION"`
}

func LoadConfig(path string) (config Config, err error) {
	// viper.AddConfigPath(path)
	// viper.SetConfigName("")
	// viper.SetConfigType("env")
	// viper.AutomaticEnv()
	// err = viper.ReadInConfig()
	// if err != nil {
	// 	return
	// }
	// err = viper.Unmarshal(&config)
	// return
	err = godotenv.Load()
	if err != nil {
		return Config{}, err
	}

	config.DBDriver = os.Getenv("DB_DRIVER")
	config.DBSource = os.Getenv("DB_SOURCE")
	config.ServerAddress = os.Getenv("SERVER_ADDRESS")
	config.TokenSymmetricKey = os.Getenv("TOKEN_SYMMETRIC_KEY")
	config.AccessTokenDuration, err = time.ParseDuration(os.Getenv("ACCESS_TOKEN_DURATION"))
	config.RefreshTokenDuration, err = time.ParseDuration(os.Getenv("REFRESH_TOKEN_DURATION"))

	return config, nil
}
