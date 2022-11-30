import { ethers } from "hardhat";

export async function deploy(name: string, args: string[] = []) {
  const Contract = await ethers.getContractFactory(name);
  const contract = await Contract.deploy(...args);
  await contract.deployed();
  return contract
}

export async function deployAll({
  tokenDecimals = 18
}) {
  const mockToken = await deploy("MockToken", [tokenDecimals.toString()]);
  const llamaPayFactory = await deploy("LlamaPayFactory")
  await llamaPayFactory.createLlamaPayContract(mockToken.address)

  const llamaPayAddress = (await llamaPayFactory.getLlamaPayContractByToken(mockToken.address))[0];
  const LlamaPay = await ethers.getContractFactory("LlamaPay");
  const llamaPay = await LlamaPay.attach(llamaPayAddress)
  return { llamaPay, llamaPayFactory, token: mockToken }
}