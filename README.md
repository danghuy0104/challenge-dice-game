# Cách chạy từng bước của code:

## Trước tiên, cần cài đặt cái tool sau:

- Node (>= v20.18.03)
- Yarn (v1 or v2+)
- Git

## Sau đó clone mã nguồn của dự án từ github về máy, cài đặt yarn và khởi chạy local network trong cùng một terminal:

```bash
yarn install
cd challenge-dice-game
yarn chain
```

## Mở terminal thứ hai và bắt đầu deploy contract (local):

```bash
cd challenge-dice-game
yarn deploy
```

## Mở terminal thứ ba và bắt đầu khởi chạy frontend:

```bash
cd challenge-dice-game
yarn start
```

## Mở http://localhost:3000 để truy cập vào ứng dụng.