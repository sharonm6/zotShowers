import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default async function handler(req, res) {
  if (req.method == 'GET') {
    console.log('Fetched user info');
    const courses = await prisma.course.findMany();
    res.status(200).json({ data: courses });
  } else {
    console.log('Created user');
    await prisma.course.create({ data: JSON.parse(req.body) });
    res.status(200).json({ message: 'SUCESS' });
  }
}
